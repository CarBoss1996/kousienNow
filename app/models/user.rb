# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2, :line]
  has_one_attached :avatar
  validate :name_fields, on: :create
  validate :avatar_type
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, if: :password_required?
  validates :email, presence: true, if: :email_required?
  has_many :posts, dependent: :destroy
  has_many :user_locations
  has_many :locations, through: :user_locations
  has_many :like_posts, dependent: :destroy
  has_many :liked_posts, through: :like_posts, source: :post
  has_many :comments, dependent: :destroy
  has_many :user_matches
  has_many :matches, through: :user_matches
  has_many :sns_credentials

  VALID_PASSWORD_REGEX = /\A[\w+\-.!@#$%^&*]+\z/
  validates_format_of :password, with: VALID_PASSWORD_REGEX, message: 'は半角英数字と記号のみ使用できます', allow_blank: true
  enum role: { general: 0, admin: 1 }

  def self.from_omniauth(auth)
    sns_credential = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_initialize
    user = User.joins(:sns_credentials).where('sns_credentials.provider = ? AND sns_credentials.uid = ?', auth.provider, auth.uid).first
    Rails.logger.error "user found: #{user.inspect}"

    if user.nil?
      user = User.new(
        user_name: auth.info.name,
        password: Devise.friendly_token[0,20]
      )

      if auth.provider == 'line'
        user.email = auth.info.email.present? ? auth.info.email : "#{auth.uid}@kasutamu.line"
        user.skip_confirmation!
      else
        user.email = auth.info.email
      end

      user.role = :admin if user.email == ENV['ADMIN_EMAIL']
      Rails.logger.error "new user created: #{user.inspect}"

      sns_credential.user = user
      user.sns_credentials << sns_credential unless user.sns_credentials.exists?(sns_credential.id)
      Rails.logger.error "sns_credential associated with user: #{sns_credential.inspect}"

      if user.save
        Rails.logger.error "user saved successfully: #{user.inspect}"
      else
        Rails.logger.error "User validation failed: #{user.errors.full_messages.join(", ")}"
      end
    end

    user
  end

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user if user&.valid_password?(password)
  end

  def avatar_type
    if avatar.attached? && !avatar.content_type.in?(%w(image/jpeg image/png))
      errors.add(:avatar, 'must be a JPEG or PNG or JPG')
    end
  end

  def avatar_variant
    avatar.variant(resize_to_limit: [100, 100])
  end

  def own?(object)
    id == object&.user_id.to_i
  end

  def latest_post
    self.posts.order(created_at: :desc).first
  end

  def like(post)
    like_posts.create(post_id: post.id)
  end

  def unlike(post)
    like_posts.find_by(post_id: post.id)&.destroy
  end

  def like?(post)
    like_posts.exists?(post_id: post.id)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[first_name last_name role user_name]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[comments like_posts liked_posts]
  end

  def self.roles_i18n
    roles.keys.map do |key|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.roles.#{key}"), key]
    end.to_h
  end

  def role_i18n
    I18n.t("activerecord.attributes.#{self.class.model_name.i18n_key}.roles.#{role}")
  end

  def name_fields
    if !google_or_line_auth?
      errors.add(:first_name, "を入力してください") if first_name.blank?
      errors.add(:last_name, "を入力してください") if last_name.blank?
      errors.add(:user_name, "を入力してください") if user_name.blank?
    end
  end

  def email_required?
    super && !line_auth?
  end

  def will_save_change_to_email?
    super && !line_auth?
  end

  private

  def password_required?
    google_or_line_auth? && super
  end

  def google_or_line_auth?
    sns_credentials.any? { |credential| ["google_oauth2", "line"].include?(credential.provider) }
  end

  def line_auth?
    sns_credentials.any? { |credential| credential.provider == 'line' }
  end
end

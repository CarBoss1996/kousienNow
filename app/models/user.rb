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
    sns_credential = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = sns_credential.user
    if user.nil?
      user = User.where(email: auth.info.email).first if auth.provider == 'google_oauth2'
      if user.nil?
        user = User.new(
          user_name: auth.info.name,
          password: Devise.friendly_token[0,20],
          uid: auth.uid
        )
        case auth.provider
        when 'google_oauth2'
          user.email = auth.info.email
          user.first_name = auth.info.first_name
          user.last_name = auth.info.last_name
          user.role = :admin if user.email == ENV['ADMIN_EMAIL']
        end
      end
      user.sns_credentials << sns_credential unless user.sns_credentials.exists?(sns_credential.id)
      unless user.save
        Rails.logger.error "ここを見て！！！User validation failed: #{user.errors.full_messages.join(", ")}"
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
    if provider.blank? # providerが空（つまり、通常の登録）の場合
      errors.add(:first_name, "を入力してください") if first_name.blank?
      errors.add(:last_name, "を入力してください") if last_name.blank?
      errors.add(:user_name, "を入力してください") if user_name.blank?
    end
  end

  def email_required?
    sns_credentials.first&.provider.blank?
  end

  private

  def password_required?
    provider.blank? && super
  end
end

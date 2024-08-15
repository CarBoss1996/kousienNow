# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sns_credential, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  has_one_attached :avatar
  validates :first_name, :last_name, :user_name, presence: true, length: { maximum: 255 }
  validate :avatar_type
  has_many :posts, dependent: :destroy
  has_many :user_locations
  has_many :locations, through: :user_locations
  has_many :like_posts, dependent: :destroy
  has_many :liked_posts, through: :like_posts, source: :post
  has_many :comments, dependent: :destroy
  has_many :user_matches
  has_many :matches, through: :user_matches

  VALID_PASSWORD_REGEX = /\A[\w+\-.!@#$%^&*]+\z/
  validates_format_of :password, with: VALID_PASSWORD_REGEX, message: 'は半角英数字と記号のみ使用できます', allow_blank: true
  enum role: { general: 0, admin: 1 }

  class << self
    def without_sns_data(auth)
      user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.create(
          name: auth.info.name,
          email: auth.info.email,
          profile_image: auth.info.image,
          password: Devise.friendly_token[0,20]
        )
        sns = SnsCredential.create(
          user_id: user.id,
          uid: auth.uid,
          provider: auth.provider
        )
      end
      { user: user, sns: sns }
    end

    def with_sns_data(auth, snscredential)
      user = User.where(id: snscredential.user_id).first
      if user.blank?
        user = User.create(
          name: auth.info.name,
          email: auth.info.email,
          profile_image: auth.info.image,
          password: Devise.friendly_token[0,20]
        )
      end
      { user: user }
    end

    def find_oauth(auth)
      uid = auth.uid
      provider = auth.provider
      snscredential = SnsCredential.where(uid: uid, provider: provider).first
      if snscredential.present?
        user = with_sns_data(auth, snscredential)[:user]
        sns = snscredential
      else
        result = without_sns_data(auth)
        user = result[:user]
        sns = result[:sns]
      end
      { user: user, sns: sns }
    end
  end

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user if user&.valid_password?(password)
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def full_name
    "#{last_name} #{first_name}"
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
end

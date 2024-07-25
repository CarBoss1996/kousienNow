# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
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
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.user_name = "#{auth.info.first_name} #{auth.info.last_name}"
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.password = Devise.friendly_token[0,20]
      user.uid = create_unique_string if user.uid.blank?
      user.role = :admin if user.email == ENV['ADMIN_EMAIL']
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
end

# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  validates :first_name, :last_name, :user_name, presence: true, length: { maximum: 255 }
  validate :avatar_type
  has_many :posts, dependent: :destroy
  has_many :user_locations
  has_many :locations, through: :user_locations

  VALID_PASSWORD_REGEX = /\A[\w+\-.!@#$%^&*]+\z/
  validates_format_of :password, with: VALID_PASSWORD_REGEX, message: 'は半角英数字と記号のみ使用できます', allow_blank: true

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user if user&.valid_password?(password)
  end

  def full_name
    "#{first_name} #{last_name}"
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
end


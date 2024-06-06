class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, :user_name, presence: true, length: { maximum: 255 }

  VALID_PASSWORD_REGEX = /\A[\w+\-.!@#$%^&*]+\z/
  validates_format_of :password, with: VALID_PASSWORD_REGEX, message: 'は半角英数字と記号のみ使用できます', allow_blank: true

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user if user&.valid_password?(password)
  end
end

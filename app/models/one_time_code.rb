class OneTimeCode < ApplicationRecord
  belongs_to :user

  validates :code, presence: true
  validates :expires_at, presence: true
end

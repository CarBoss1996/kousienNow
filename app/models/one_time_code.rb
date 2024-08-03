class OneTimeCode < ApplicationRecord
  belongs_to :user

  validates :code, presence: true
  validates :expires_at, presence: true

  def code_presence
    errors.add(:code, 'を入力してください') if code.blank?
  end
end

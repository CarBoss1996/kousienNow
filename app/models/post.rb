class Post < ApplicationRecord
  has_one_attached :image
  validates :body, presence: true, length: { maximum: 255 }
  belongs_to :user
end

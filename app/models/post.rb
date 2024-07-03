class Post < ApplicationRecord
  has_one_attached :image
  validates :body, presence: true, length: { maximum: 255 }
  belongs_to :user
  has_many :like_posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "id_value", "image", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[comments image_attachment image_blob like_posts user]
  end
end

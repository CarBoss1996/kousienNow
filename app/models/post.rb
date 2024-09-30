# frozen_string_literal: true

class Post < ApplicationRecord
  has_one_attached :image
  validates :body, presence: true, length: { maximum: 255 }
  belongs_to :user
  has_many :like_posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[body created_at id id_value image updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[comments image_attachment image_blob like_posts user]
  end

  def line_user_id
    user.line_user_id
  end
end

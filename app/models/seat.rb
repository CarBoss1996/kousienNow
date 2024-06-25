class Seat < ApplicationRecord
  has_many :shapes
  has_many :user_locations
  belongs_to :locations
  accepts_nested_attributes_for :shapes
end

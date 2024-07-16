class Seat < ApplicationRecord
  has_many :shapes
  has_many :user_locations
  belongs_to :location
  accepts_nested_attributes_for :shapes
end

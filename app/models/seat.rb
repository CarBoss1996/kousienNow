class Seat < ApplicationRecord
  has_many :shapes
  has_many :user_locations
  belongs_to :location
end

class Seat < ApplicationRecord
  has_many :user_locations
  belongs_to :location
end

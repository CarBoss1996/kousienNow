class Seat < ApplicationRecord
  has_many :shapes
  accepts_nested_attributes_for :shapes
end

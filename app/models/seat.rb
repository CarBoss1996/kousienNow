class Seat < ApplicationRecord
  has_many :shapes
  accepts_nested_attributes_for :shapes
  enum seat: {
    backnet: 1,
    smbc_seat: 2,
    ivy_seat: 3,
    breeze_seat: 4,
    first_base_alps: 5,
    third_base_alps: 6,
    right_outfield: 7,
    left_outfield: 8,
    home_cheering: 9
  }
end

class Seat < ApplicationRecord
  has_many :shapes
  accepts_nested_attributes_for :shapes
  enum seat: {
    backnet: 0,
    smbc_seat: 1,
    ivy_seat: 2,
    breeze_seat: 3,
    first_base_alps: 4,
    third_base_alps: 5,
    right_outfield: 6,
    left_outfield: 7,
    home_cheering: 8
  }
end

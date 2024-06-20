class Location < ApplicationRecord
  has_many :user_locations
  has_many :users, through: :user_locations
  enum icon: { heart: 0, tiger: 1, beer: 2, chu_hi: 3, curry: 4 }

  validates :icon, presence: true
  enum seat_id: {
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

  def self.create_with_seat(user, location_params)
    location = user.locations.build(location_params)
    if location.seat_id
      location.save ? location : location
    else
      location.errors.add(:seat, "シート名が見つかりませんでした。")
      location
    end
  end
end

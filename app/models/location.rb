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
    seat = Seat.find_by(seat_name: location_params[:seat_id])
    location = user.locations.build(location_params.except(:seat_id))
    if seat
      location.seat_id = seat.id
      location.save ? location : nil
    else
      nil
    end
  end
end

class Location < ApplicationRecord
  # belongs_to :seat
  has_many :user_locations
  has_many :users, through: :user_locations
  enum icon: { heart: 0, tiger: 1, beer: 2, chu_hi: 3, curry: 4 }
  enum name: Seat.seats

  validates :icon, presence: true
  validates :seat_id, presence: true

  def self.create_with_seat(location_params, user)
    location = new(location_params)
    Rails.logger.info(location)
    if location.save
      user.user_locations.create(location: location)
    else
      Rails.logger.error(location.errors.full_messages.join(", "))
    end

    location
  end
end

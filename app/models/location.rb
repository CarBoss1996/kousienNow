class Location < ApplicationRecord
  attribute :seat_name, :integer
  attribute :points, :jsonb, default: {}
  belongs_to :seat
  has_many :user_locations
  has_many :users, through: :user_locations
  enum icon: { heart: 0, tiger: 1, beer: 2, chu_hi: 3, curry: 4 }
  enum seat_name: Seat.seats

  validates :icon, presence: true
  validates :seat_id, presence: true

  def self.create_with_seat(location_params, user)
    location = new(location_params)

    if location.save
      user.user_locations.create(location: location)
      Rails.logger.info(location)
    else
      Rails.logger.error(location.errors.full_messages.join(", "))
    end

    location
  end
end

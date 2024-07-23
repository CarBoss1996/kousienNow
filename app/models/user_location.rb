class UserLocation < ApplicationRecord
  after_create :set_date, :set_location_type

  belongs_to :user
  belongs_to :location
  belongs_to :seat, optional: true
  enum icon: { heart: 0, tiger: 1, beer: 2, chu_hi: 3, curry: 4 }
  enum location_type: Location.location_types

  validates :icon, presence: true
  validates :location_id, presence: true

  def self.create_with_seat(location_params, user)
    user_location = new(location_params.merge(user_id: user.id))

    if user_location.save
      location = user_location.location
    else
      Rails.logger.error(user_location.errors.full_messages.join(", "))
      raise "Failed to save UserLocation"
    end

    user_location
  end

  private

  def set_date
    self.update(date: self.created_at.to_date)
  end

  def set_location_type
    location = Location.find(self.location_id)
    self.update(location_type: location.location_type)
  end
end

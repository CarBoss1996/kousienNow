class UserLocation < ApplicationRecord
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
      if location.nil?
        Rails.logger.error("Location with id #{location_params[:location_id]} not found")
      end
    else
      Rails.logger.error(user_location.errors.full_messages.join(", "))
    end

    user_location
  end
end

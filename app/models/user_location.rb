class UserLocation < ApplicationRecord
  after_create :set_date, :set_location_type
  before_create :set_index
  after_create :calculate_offset

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

  def calculate_offset
    points = JSON.parse(location.points)
    return [0, 0] unless points.present?

    top = points.sum { |point| point["y"].to_i } / points.size
    left = points.sum { |point| point["x"].to_i } / points.size
    width = points.max_by { |point| point["x"].to_i }["x"].to_i - points.min_by { |point| point["x"].to_i }["x"].to_i
    height = points.max_by { |point| point["y"].to_i }["y"].to_i - points.min_by { |point| point["y"].to_i }["y"].to_i
    offset_x = (index % 3) * (width / 3.0) - (width / 3.0)
    offset_y = (index / 3 % 3) * (height / 3.0) - (height / 3.0)
    [left + offset_x, top + offset_y]
  end

  private

  def set_date
    self.update(date: self.created_at.to_date)
  end

  def set_location_type
    location = Location.find(self.location_id)
    self.update(location_type: location.location_type)
  end

  def set_index
    last_index = UserLocation.order(index: :desc).first&.index || -1
    self.index = last_index + 1
  end
end

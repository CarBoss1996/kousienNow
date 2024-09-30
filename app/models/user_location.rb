# frozen_string_literal: true

class UserLocation < ApplicationRecord
  after_create :set_date, :set_location_type
  before_create :set_index
  after_create :calculate_offset

  belongs_to :user
  belongs_to :location
  enum icon: { heart: 0, tiger: 1, beer: 2, chu_hi: 3, curry: 4 }
  enum location_type: Location.location_types

  validates :icon, presence: true
  validates :location_id, presence: true

  def self.create_with_seat(location_params, user)
    user_location = new(location_params.merge(user_id: user.id))

    user_location.save

    user_location
  end

  def calculate_offset
    points = JSON.parse(location.points)
    return [0, 0] unless points.present?

    top = points.sum { |point| point['y'].to_i } / points.size
    left = points.sum { |point| point['x'].to_i } / points.size
    width = points.max_by { |point| point['x'].to_i }['x'].to_i - points.min_by { |point| point['x'].to_i }['x'].to_i
    height = points.max_by { |point| point['y'].to_i }['y'].to_i - points.min_by { |point| point['y'].to_i }['y'].to_i

    # Ensure the icon does not go outside the points area
    offset_x = (index % 3) * (width / 3.0)
    offset_y = (index / 3) * (height / 3.0)

    # Ensure the icon does not go outside the image
    offset_x = [offset_x, width].min
    offset_y = [offset_y, height].min

    [left + offset_x, top + offset_y]
  end

  private

  def set_date
    update(date: created_at.to_date)
  end

  def set_location_type
    location = Location.find(location_id)
    update(location_type: location.location_type)
  end

  def set_index
    last_index = UserLocation.order(index: :desc).first&.index || -1
    self.index = last_index + 1
  end
end

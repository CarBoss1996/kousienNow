# frozen_string_literal: true

class Location < ApplicationRecord
  attribute :points, :jsonb, default: {}
  has_many :user_locations
  has_many :seats
  has_many :users, through: :user_locations
  enum location_type: {
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

  def seat_name_ja
    I18n.t("seats.#{seat_name}")
  end
end

# frozen_string_literal: true

module Api
  class SeatSerializer < ActiveModel::Serializer
    attributes :id, :seat_name, :latitude, :longitude, :created_at, :updated_at, :location_type, :spots, :location_id

    def seat_name
      I18n.t("seats.#{object.seat_name}")
    end
  end
end

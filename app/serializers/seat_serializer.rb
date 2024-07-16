class SeatSerializer < ActiveModel::Serializer
  attributes :id, :seat_name, :latitude, :longitude, :created_at, :updated_at, :location_type, :spots, :location_id
end
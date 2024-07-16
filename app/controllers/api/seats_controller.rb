module Api
  class SeatsController < ApplicationController
    def index
      seats = Seat.all
      seats_with_translation = seats.map do |seat|
        seat.attributes.merge(
          "seat_name" => I18n.t("seats.#{seat.seat_name}")
        )
      end
      render json: seats_with_translation
    end
  end
end

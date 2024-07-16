module Api
  class SeatsController < ApplicationController
    def index
      @seats = Seat.all
      render json: @seats, each_serializer: Api::SeatSerializer
    end
  end
end

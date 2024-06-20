class SeatsController < ApplicationController
  def show
    @seat = Seat.find(params[:id])
    @shapes = @seat.shapes
  end

  private
  def seat_params
    params.require(:seat).permit(:id, :name, :seat)
  end
end

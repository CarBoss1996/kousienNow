class LocationsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def index; end

  def new
    @location = Location.new
  end

  def create
    last_location = current_user.locations.order(created_at: :desc).first
    if last_location && last_location.created_at.to_date == Date.today
      flash[:danger] = t('location.create.already')
      render :top
    else
      @location = Location.create_with_seat(current_user, location_params) || Location.new(location_params)
      if @location.persisted?
        redirect_to root_path, success: t('locations.create.success')
      else
        flash.now[:danger] = t('locations.create.failure')
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def location_params
    seat = Seat.find_by(seat_name: params[:location][:seat_name])
    params.require(:location).permit(:icon).merge(seat_id: seat ? seat.id : nil)
  end
end

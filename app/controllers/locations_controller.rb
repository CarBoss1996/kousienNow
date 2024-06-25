class LocationsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def index; end

  def show
    location = Seat.find(params[:id])
    @points = JSON.parse(location.points)
  end

  def new
    @location = Location.new
  end

  def create
    Rails.logger.info(location_params)
    last_location = current_user.locations.order(created_at: :desc).first
    if last_location && last_location.created_at.to_date == Date.today
      flash[:danger] = t('locations.create.already')
      redirect_to root_path
    else
      @location = Location.create_with_seat(location_params.merge(icon: location_params[:icon].to_i), current_user)
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
    params.require(:location).permit(:seat_id, :icon)
  end
end

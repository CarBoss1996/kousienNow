class LocationsController < ApplicationController
  def index; end

  def new
    @location = Location.new
  end

  def create
    last_location = current_user.locations.order(created_at: :desc).first
    if last_location && last_location.created_at.to_date == Date.today
      flash[:danger] = t('location.create.already')
      render :new
    else
      @location = current_user_locations.build(location_params)
      if @location.save
        redirect_to locations_path
      else
        render :new
      end
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :icon)
  end
end

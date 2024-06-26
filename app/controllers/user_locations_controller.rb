class UserLocationsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :validate_location_id, only: [:create]

  def index; end

  def show
    location = Location.find(params[:id])
    @points = JSON.parse(location.points)
  end

  def new
    @user_location = UserLocation.new
  end

  def create
    Rails.logger.info(user_location_params)
    last_user_location = current_user.user_locations.order(created_at: :desc).first
    if last_user_location && last_user_location.created_at.to_date == Date.today
      flash[:danger] = t('user_locations.create.already')
      redirect_to root_path
    else
      @user_location = UserLocation.create_with_seat(user_location_params.merge(icon: user_location_params[:icon].to_i), current_user)
      if @user_location.persisted?
        redirect_to root_path, success: t('user_locations.create.success')
      else
        flash.now[:danger] = t('user_locations.create.failure')
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def user_location_params
    params.require(:user_location).permit(:location_id, :icon)
  end

  def validate_location_id
    unless Location.exists?(user_location_params[:location_id])
      flash[:danger] = t('user_locations.create.invalid_location')
      redirect_to new_user_location_path
      return
    end
  end
end
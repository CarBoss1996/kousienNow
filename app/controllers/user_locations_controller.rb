# frozen_string_literal: true

class UserLocationsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :validate_location_id, only: [:create]
  def new
    @user_location = UserLocation.new
    @location = Location.find_by(id: params[:location_id])
  end

  def create
    Rails.logger.info(user_location_params)
    last_user_location = current_user.user_locations.order(created_at: :desc).first

    if last_user_location && last_user_location.created_at.to_date == Date.today
      flash[:danger] = t('user_locations.create.already')
      redirect_to root_path and return
    end

    @user_location = UserLocation.create_with_seat(user_location_params.merge(icon: user_location_params[:icon].to_i),
                                                   current_user)

    unless @user_location.persisted?
      flash.now[:danger] = t('user_locations.create.failure')
      render :new, status: :unprocessable_entity and return
    end

    Rails.logger.info "ここを見て！！！！show_modal: #{params[:show_modal]}"
    redirect_to root_path(show_modal: true)
  end

  private

  def user_location_params
    params.require(:user_location).permit(:location_id, :icon)
  end

  def validate_location_id
    return if Location.exists?(user_location_params[:location_id])

    flash[:danger] = t('user_locations.create.invalid_location')
    redirect_to new_user_location_path
    nil
  end
end

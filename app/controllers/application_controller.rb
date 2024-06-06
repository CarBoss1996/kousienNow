class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :danger

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name,:user_name])
  end
end
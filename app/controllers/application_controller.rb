# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :danger

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[last_name first_name user_name])
  end

  def after_sign_out_path_for(_resource_or_scope)
    flash[:notice] = 'ログアウトしました'
    root_path
  end
end

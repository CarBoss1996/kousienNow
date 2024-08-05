# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :danger

  def authenticate_user!
    if user_signed_in?
      super
    else
      store_location
      session[:user_return_to] = request.fullpath
      redirect_to new_user_session_path, :notice => 'ログインしてください。'
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[last_name first_name user_name])
  end

  def after_sign_in_path_for(resource)
    session.delete(:previous_url) || root_path
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def after_sign_out_path_for(_resource_or_scope)
    flash[:notice] = 'ログアウトしました'
    root_path
  end

  def fetch_weather
    api_key = ENV['OPENWEATHERMAP_API_KEY']
    lat = 34.72131408883499 # 阪神甲子園球場の緯度
    lon = 135.36163605135255 # 阪神甲子園球場の経度
    url = "http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&appid=#{api_key}&units=metric&lang=ja"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    # 天気の説明と気温を抽出
    description = data['weather'][0]['description']
    icon_id = data['weather'][0]['icon']
    temp_celsius = data['main']['temp'].round(1)

    # アイコンのURLを生成
    icon_url = "http://openweathermap.org/img/w/#{icon_id}.png"

    # 必要な情報をハッシュとして返す
    { description: description, temp_celsius: temp_celsius, icon_url: icon_url }
  end
end
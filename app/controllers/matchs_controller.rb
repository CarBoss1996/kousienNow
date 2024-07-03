require 'httparty'
require 'json'
require 'uri'

class MatchsController < ApplicationController
  def index
    @matches = Match.where(match_date: Date.today.beginning_of_day..Date.today.end_of_day).order(match_date: :desc, created_at: :desc)
    @weather = fetch_weather
  end

  def show
    @match = Match.find(params[:id])
  end

  def kelvin_to_celsius(kelvin)
    kelvin - 273.15
  end
end

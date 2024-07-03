require 'httparty'
require 'json'
require 'uri'

class MatchsController < ApplicationController
  def index
    @matches = Match.where(match_date: Date.today.beginning_of_day..Date.today.end_of_day)
            .group(:match_date)
            .maximum(:created_at)
            .map { |match_date, created_at| Match.find_by(match_date: match_date, created_at: created_at) }
    @weather = fetch_weather
  end

  def show
    @match = Match.find(params[:id])
  end

  def kelvin_to_celsius(kelvin)
    kelvin - 273.15
  end
end

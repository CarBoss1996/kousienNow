require 'httparty'
require 'json'
require 'uri'

class MatchesController < ApplicationController
  before_action :set_beginning_of_week, only: [:index]
  def index
    @matches = Match.order(match_date: :desc)
  end

  def show
    @match = Match.find(params[:id])
  end

  def kelvin_to_celsius(kelvin)
    kelvin - 273.15
  end

  def show_month
    @month = params[:month].to_i
  end

  private
  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
end

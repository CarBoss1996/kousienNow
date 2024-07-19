require 'httparty'
require 'json'
require 'uri'

class MatchesController < ApplicationController
  before_action :set_beginning_of_week
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
    begin
      @month = params[:month] ? Date.strptime(params[:month], "%Y-%m") : Date.today
    rescue ArgumentError
      @month = Date.today
    end
    @matches = Match.where(match_date: @month.beginning_of_month..@month.end_of_month).order(match_date: :desc)
    render 'index', layout: 'application'
  end

  private

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
end

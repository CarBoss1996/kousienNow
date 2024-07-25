require 'httparty'
require 'json'
require 'uri'

class MatchesController < ApplicationController
  before_action :set_beginning_of_week
  before_action :authenticate_user!, only: [:add_to_schedule]
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @month = @date.beginning_of_month
    @matches = Match.where(match_date: @month.beginning_of_month..@date.end_of_month).order(match_date: :desc)
    if current_user
      @user_matches = current_user.user_matches.where(date: @month.beginning_of_month..@month.end_of_month)
      @user_locations = current_user.user_locations.where(date: @month.beginning_of_month..@date.end_of_month)
    else
      @user_matches = []
      @user_locations = []
    end
  end

  def show
    @user = User.find(params[:id])
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
    @user_locations = current_user.user_locations.where(date: @month.beginning_of_month..@month.end_of_month)
    @user_matches = current_user.user_matches.where(date: @month.beginning_of_month..@month.end_of_month)
    render 'index', layout: 'application'
  end

  def add_to_schedule
    date = Date.parse(params[:date])
    @match = Match.where(match_date: date.beginning_of_day..date.end_of_day).first
    user_match = current_user.user_matches.build(date: date, match: @match)
    if user_match.save
      redirect_to matches_path, notice: '観戦予定を登録しました'
    else
      redirect_to matches_path, alert: '観戦予定の登録に失敗しました'
    end
  end

  private

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
end

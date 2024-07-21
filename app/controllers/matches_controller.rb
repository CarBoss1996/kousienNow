require 'httparty'
require 'json'
require 'uri'

class MatchesController < ApplicationController
  before_action :set_beginning_of_week
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @month = @date.beginning_of_month
    @matches = Match.where(match_date: @month.beginning_of_month..@date.end_of_month).order(match_date: :desc)
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
    render 'index', layout: 'application'
  end

  def add_to_schedule
    @match = Match.find(params[:id])
    date = params[:date]
    schedule = current_user.schedules.build(date: date, match: @match)
    if schedule.save
      redirect_to matches_path, notice: '観戦予定を登録しました'
    else
      render :schedule
    end
  end

  def schedule
    @matches = Match.all
  end

  private

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
end

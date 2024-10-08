# frozen_string_literal: true

require 'httparty'
require 'json'
require 'uri'

class MatchesController < ApplicationController
  before_action :set_beginning_of_week
  before_action :authenticate_user!, only: [:add_to_schedule]

  def index
    @date = params[:date] ? Time.zone.parse(params[:date]) : Time.zone.today
    @month = @date.beginning_of_month
    @matches = Rails.cache.fetch("matches/#{@month}", expires_in: 12.hours) do
      Match.where(match_date: @month.beginning_of_month..@date.end_of_month).order(match_date: :desc)
    end
    @events = Rails.cache.fetch("events/#{@month}", expires_in: 12.hours) do
      Event.eager_load(:event_dates)
           .where('event_dates.start_date <= :end_of_month AND event_dates.end_date >= :start_of_month', start_of_month: @month.beginning_of_month, end_of_month: @month.end_of_month)
    end
    logger.debug @events.inspect
    if current_user
      @user_matches = current_user.user_matches.where(date: @month.beginning_of_month..@month.end_of_month)
      @user_locations = current_user.user_locations.where(date: @month.beginning_of_month..@date.end_of_month)
    else
      @user_matches = []
      @user_locations = []
    end
  end

  def kelvin_to_celsius(kelvin)
    kelvin - 273.15
  end

  def show_month
    begin
      @month = params[:month] ? Time.zone.strptime(params[:month], '%Y-%m') : Time.zone.today
    rescue ArgumentError
      @month = Time.zone.today
    end
    if current_user
      @user_locations = current_user.user_locations.where(date: @month.beginning_of_month..@month.end_of_month)
      @user_matches = current_user.user_matches.where(date: @month.beginning_of_month..@month.end_of_month)
    else
      @user_locations = []
      @user_matches = []
    end
    @matches = Rails.cache.fetch("matches/#{@month}", expires_in: 12.hours) do
      Match.where(match_date: @month.beginning_of_month..@month.end_of_month).order(match_date: :desc)
    end
    @events = Rails.cache.fetch("events/#{@month}", expires_in: 12.hours) do
      Event.eager_load(:event_dates)
           .where('event_dates.start_date <= :end_of_month AND event_dates.end_date >= :start_of_month', start_of_month: @month.beginning_of_month, end_of_month: @month.end_of_month)
    end
    logger.debug @events.inspect
    render 'index', layout: 'application'
  end

  def add_to_schedule
    date = Time.zone.parse(params[:date])
    @match = Match.where(match_date: date.beginning_of_day..date.end_of_day).first
    if @match
      user_match = current_user.user_matches.build(date:, match: @match)
      if user_match.save
        redirect_to matches_path, notice: '観戦予定を登録しました'
      else
        redirect_to matches_path, alert: '観戦予定の登録に失敗しました'
      end
    else
      redirect_to matches_path, alert: '該当する試合が見つかりませんでした'
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    redirect_to matches_path, notice: '試合情報を削除しました'
  end

  private

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
end

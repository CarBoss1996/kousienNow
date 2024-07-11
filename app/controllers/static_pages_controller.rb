# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def top
    @users = User.all
    @posts = Post.all.order(created_at: :desc)
    @weather = fetch_weather
    @matches = Match.where(match_date: Date.today.beginning_of_day..Date.today.end_of_day)
  end

  def privacy_policy; end

  def terms_of_service; end
end

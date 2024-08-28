# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def top
    @prompt_email = user_signed_in? && current_user.email.nil?
    @users = User.all
    @posts = Post.order(created_at: :desc).limit(3)
    @weather = fetch_weather
    @matches = Match.where(match_date: Date.today.beginning_of_day..Date.today.end_of_day)
    @set_new_user_in_session_storage = session.delete(:new_user)
  end

  def privacy_policy; end

  def terms_of_service; end
end

# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def top
    @users = User.all
    @posts = Post.all.order(created_at: :desc)
    @weather = fetch_weather
  end
end

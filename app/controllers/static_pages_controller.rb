# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def top
    @users = User.all
    @posts = Post.all
  end
end

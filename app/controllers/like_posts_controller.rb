class LikePostsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
  end

  def destroy
    @post = current_user.like_posts.find(params[:id]).post
    current_user.unlike(@post)
  end
end

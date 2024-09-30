# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    flash[:success] = t('.success') if @comment.save
    respond_to do |format|
      format.turbo_stream { render 'comments/create' }
      format.html { redirect_to @comment }
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    flash[:success] = t('.success')
    respond_to do |format|
      format.turbo_stream { render 'comments/destroy' }
      format.html { redirect_to comments_url }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
end

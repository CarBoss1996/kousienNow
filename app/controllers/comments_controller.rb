class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    flash.now[:success] = t('.success')
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    flash.now[:success] = t('.success')
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
end

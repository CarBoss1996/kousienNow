class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = t('.success')
      # コメントが保存された後に、通知を作成してLINE通知を送信
      message = "#{@comment.post.user.user_name}さん、あなたの投稿に#{current_user.user_name}さんからコメントがあります。#{@comment.body}"
      Notification.create_and_send_line_notification(@comment.post.user, message)
    end
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

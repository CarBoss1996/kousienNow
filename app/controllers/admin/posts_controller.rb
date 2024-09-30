# frozen_string_literal: true

module Admin
  class PostsController < Admin::BaseController
    before_action :set_post, only: %i[show edit update destroy]

    def index
      if params[:q] && params[:q][:created_at_lteq]
        params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date + 1.day
      end
      @q = Post.ransack(params[:q])
      @posts = @q.result(distinct: true).page(params[:page]).per(10)
    end

    def show; end

    def edit; end

    def update
      if @post.update(post_params)
        flash[:success] = I18n.t('defaults.flash_message.updated')
        redirect_to admin_posts_path
      else
        Rails.logger.debug(@post.errors.full_messages.join(', '))
        flash.now[:danger] = I18n.t('defaults.flash_message.not_updated')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy!
      respond_to do |format|
        format.turbo_stream do
          redirect_to admin_posts_path, success: I18n.t('defaults.flash_message.delete', item: Post.model_name.human),
                                        status: :see_other
        end
        format.html do
          redirect_to admin_posts_path, success: I18n.t('defaults.flash_message.delete', item: Post.model_name.human)
        end
      end
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :post_image)
    end
  end
end

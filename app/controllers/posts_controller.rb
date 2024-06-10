class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all.order(created_at: :asc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @current_time = I18n.l(Time.current, format: :default)
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, success: t('posts.create.success')
    else
      flash.now[:danger] = t('posts.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, success: t('posts.update.success')
    else
      flash.now[:danger] = t('posts.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to posts_path, success: t('posts.destroy.success')
  end

  private

  def post_params
    params.require(:post).permit(:body, :image)
  end
end

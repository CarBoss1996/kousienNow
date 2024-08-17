class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    unless @post
      redirect_to root_path, alert: t('posts.show.failure')
    end
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
    @current_time = I18n.l(Time.current, format: :default)
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_path, success: t('posts.create.success')
    else
      flash.now[:danger] = t('posts.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path, success: t('posts.update.success')
    else
      flash.now[:danger] = t('posts.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, success: t('posts.destroy.success')
  end

  def latest
    @user = User.find_by(user_name: params[:user_name]).decorate
    @latest_post = @user.posts.order(created_at: :desc).first
    render json: @latest_post
  end

  def like_posts
    @q = Post.joins(:like_posts).where(like_posts: { user_id: current_user.id }).ransack(params[:q])
    @liked_posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:body, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

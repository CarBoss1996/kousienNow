# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]
  before_action :set_user, only: [:show, :edit, :update]

  def show_other_user
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
    render 'show_other_user'
  end

  def show
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to profile_path, success: t('defaults.flash_message.updated', item: User.model_name.human)
    else
      flash.now['danger'] = t('defaults.flash_message.not_updated', item: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :last_name, :first_name, :avatar, :favorite_player, :favorite_viewing_block)
  end

  def set_user
    @user = current_user.decorate
  end
end

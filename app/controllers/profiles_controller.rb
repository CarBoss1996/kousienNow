# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    if @user == current_user
      render 'show_current_user'
    else
      render 'show'
    end
  end

  def edit
    @user = current_user.decorate
  end

  def update
    @user = current_user.decorate
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
end

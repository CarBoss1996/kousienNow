# frozen_string_literal: true

module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, only: %i[show edit update destroy]
    before_action :build_sns_credential, only: %i[edit update]

    def index
      @q = User.order(:id).ransack(params[:q])
      @users = @q.result(distinct: true).page(params[:page])
    end

    def show; end

    def edit; end

    def update
      if @user.update(user_params)
        flash[:success] = I18n.t('profiles.edit.success')
        redirect_to admin_user_path
      else
        flash[:danger] = I18n.t('profiles.edit.failure')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy!
      respond_to do |format|
        format.turbo_stream do
          redirect_to admin_users_path, success: I18n.t('defaults.flash_message.delete', item: User.model_name.human),
                                        status: :see_other
        end
        format.html do
          redirect_to admin_users_path, success: I18n.t('defaults.flash_message.delete', item: User.model_name.human)
        end
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def build_sns_credential
      @user.sns_credentials.build unless @user.sns_credentials.present?
    end

    def user_params
      params.require(:user).permit(:user_name, :email, :first_name, :last_name, :avatar, :favorite_player, :location_id,
                                   :role, :line_user_id, sns_credential_attributes: %i[provider uid])
    end
  end
end

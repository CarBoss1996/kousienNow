class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @q = User.ransack(params[:q])
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
      format.turbo_stream { redirect_to admin_users_path, success: I18n.t('defaults.flash_message.delete', item: User.model_name.human), status: :see_other }
      format.html { redirect_to admin_users_path, success: I18n.t('defaults.flash_message.delete', item: User.model_name.human) }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :avatar, :role)
  end
end

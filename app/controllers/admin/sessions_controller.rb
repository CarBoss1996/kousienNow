class Admin::SessionsController < Admin::BaseController
  skip_before_action :check_admin, only: %i[new create]
  layout 'admin/layouts/admin_login'

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user&.valid_password?(params[:password])
      if @user.email == ENV['ADMIN_EMAIL']
        session[:user_id] = @user.id
        flash[:success] = t('.success')
        redirect_to admin_root_path
      elsif @user.admin?
        flash[:danger] = t('.danger')
        render :new
      else
        flash[:danger] = t('defaults.flash_message.not_authorized')
        redirect_to root_path
      end
    else
      flash[:danger] = t('.invalid_credentials')
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = t('.success')
    redirect_to admin_login_path
  end

  protected

  def after_sign_in_path_for(resource)
    admin_root_path
  end
end

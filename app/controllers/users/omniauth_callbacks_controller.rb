class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, only: [:google_oauth2, :line]
  # callback for google
  def google_oauth2
    callback_for(:google)
  end

  # callback for line
  def line
    callback_for(:line)
  end

  def callback_for(provider)
    provider = provider.to_s
    @user = User.from_omniauth(request.env["omniauth.auth"])

    unless @user.persisted?
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
      return
    end

    if @user.email == ENV['ADMIN_EMAIL']
      sign_in_and_redirect @user, event: :authentication, location: admin_root_path
    else
      sign_in_and_redirect @user, event: :authentication
    end

    set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
  end

  def failure
    redirect_to new_user_session_path, alert: 'ログインに失敗しました'
  end

  private

  def sign_in_and_redirect(user, options = {})
    if user.admin?
      sign_in user
      redirect_to admin_root_path
    else
      sign_in user
      redirect_to root_path
    end
  end
end

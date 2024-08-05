class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  protect_from_forgery
  # callback for facebook
  # def facebook
  #   callback_for(:facebook)
  # end

  # # callback for twitter
  # def twitter
  #   callback_for(:twitter)
  # end

  # callback for google
  def google_oauth2
    callback_for(:google)
  end

  # def instagram
  #   callback_for(:instagram)
  # end

  # # callback for line
  # def line
  #   callback_for(:line)
  # end

  private

  # common callback method
  def callback_for(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      if @user.email == ENV['ADMIN_EMAIL']
        sign_in_and_redirect @user, event: :authentication, location: admin_root_path
        set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
      else
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
      end
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def sign_in_and_redirect(user, options = {})
    if user.admin?
      sign_in user
      redirect_to admin_root_path
    else
      super
    end
  end
end

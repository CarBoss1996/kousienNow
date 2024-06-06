class UserSessionsController < Devise::SessionsController
  def new
    @user = current_user
  end

  def create
    @user = User.authenticate(params[:email], params[:password])

    if @user
      sign_in @user
      redirect_to top, success: "ログインに成功しました"
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new, status: :unprocessable_entity
    end
  end
end

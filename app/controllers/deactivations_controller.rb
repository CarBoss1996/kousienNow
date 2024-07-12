class DeactivationsController < ApplicationController
  def new; end

  def create
    current_user.destroy
    redirect_to root_path, notice: '退会が完了しました'
  end
end

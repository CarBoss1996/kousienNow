class DeactivationsController < ApplicationController
  def new; end

  def create
    current_user.destroy
    redirect_to root_path, notice: 'Your account has been deleted.'
  end
end

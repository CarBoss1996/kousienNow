# frozen_string_literal: true

class DeactivationsController < ApplicationController
  def new; end

  def create; end

  def destroy
    current_user.destroy
    redirect_to root_path, notice: '退会が完了しました'
  end
end

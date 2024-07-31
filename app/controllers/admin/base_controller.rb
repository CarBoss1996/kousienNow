class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout 'admin/layouts/application'

  private

  def login_required
    flash.now[:danger] = t('defaults.message.require_login')
    redirect_to admin_login_path unless Current.user
  end

  def check_admin
    unless current_user&.email == ENV['ADMIN_EMAIL']
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end
end

# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :check_admin
    layout 'admin/layouts/application'

    private

    def login_required
      flash[:danger] = t('defaults.message.require_login')
      redirect_to admin_login_path unless current_user
    end

    def check_admin
      Rails.logger.debug "Current user email: #{current_user&.email}"
      Rails.logger.debug "ADMIN_EMAIL: #{ENV['ADMIN_EMAIL']}"
      return if current_user&.email == ENV['ADMIN_EMAIL']

      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end
end

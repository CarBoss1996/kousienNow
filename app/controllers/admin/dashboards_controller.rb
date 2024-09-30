# frozen_string_literal: true

module Admin
  class DashboardsController < Admin::BaseController
    before_action :login_required, unless: -> { current_user }
    def index; end
  end
end

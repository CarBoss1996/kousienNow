class Admin::DashboardsController < ApplicationController
  before_action :login_required, unless: -> { current_user }
  def index
  end
end

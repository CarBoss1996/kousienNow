class Admin::DashboardsController < Admin::BaseController
  before_action :login_required, unless: -> { current_user }
  def index
  end
end
class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    params[:q] ||= {}
    @q = Event.ransack(params[:q])
    @events = @q.result(distinct: true).page(params[:page]).order(event_date: :desc)
  end

  def show; end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to admin_event_path, success: I18n.t('events.update.success')
    else
      Rails.logger.debug(@event.errors.full_messages.join(', '))
      flash.now[:danger] = I18n.t('events.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy!
    respond_to do |format|
      format.turbo_stream { redirect_to admin_events_path, success: I18n.t('defaults.flash_message.delete', item: Event.model_name.human), status: :see_other }
      format.html { redirect_to admin_events_path, success: I18n.t('defaults.flash_message.delete', item: Event.model_name.human) }
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :body, :event_date)
  end
end
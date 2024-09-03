class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    params[:q] ||= {}
    @q = Event.ransack(params[:q])
    @events = @q.result.page(params[:page]).joins(:event_dates).order('events.id ASC')
  end

  def show; end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to admin_event_path(@event), success: I18n.t('events.create.success')
    else
      Rails.logger.debug(@event.errors.full_messages.join(', '))
      flash.now[:danger] = I18n.t('events.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to admin_event_path(@event), success: I18n.t('events.update.success')
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
    params.require(:event).permit(:title, :body, :detail_url, event_dates_attributes: [:start_date, :end_date])
  end
end

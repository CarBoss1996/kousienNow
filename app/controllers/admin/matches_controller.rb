# frozen_string_literal: true

module Admin
  class MatchesController < Admin::BaseController
    before_action :set_match, only: %i[show edit update destroy]

    def index
      params[:q] ||= { match_date_gteq: Date.today.beginning_of_month, match_date_lteq: Date.today.end_of_month }
      @q = Match.ransack(params[:q])
      @matches = @q.result(distinct: true).includes(:event).order(match_date: :asc)
    end

    def show; end

    def new
      @match = Match.new
    end

    def create
      match_params = self.match_params
      if match_params[:match_time].present?
        match_params[:match_date] =
          DateTime.parse("#{match_params[:match_date]} #{match_params[:match_time]}").in_time_zone('Asia/Tokyo')
      end
      @match = Match.new(match_params)

      if @match.save
        redirect_to admin_matches_path, notice: I18n.t('dafaults.flash_mesage.created')
      else
        render :new
      end
    end

    def edit; end

    def update
      match_params = self.match_params
      if match_params[:match_time].present?
        date = Date.parse(match_params[:match_date]).in_time_zone('Asia/Tokyo')
        time = Time.parse(match_params[:match_time]).seconds_since_midnight.seconds
        match_params[:match_date] = date + time
      end
      if @match.update(match_params)
        redirect_to admin_matches_path, success: I18n.t('matches.update.success')
      else
        Rails.logger.debug(@match.errors.full_messages.join(', '))
        flash.now[:danger] = I18n.t('matches.update.failure')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @match.user_matches.destroy_all
      @match.destroy!
      respond_to do |format|
        format.turbo_stream do
          redirect_to admin_matches_path, success: I18n.t('defaults.flash_message.delete', item: Match.model_name.human),
                                          status: :see_other
        end
        format.html do
          redirect_to admin_matches_path, success: I18n.t('defaults.flash_message.delete', item: Match.model_name.human)
        end
      end
    end

    def show_month
      year, month = params[:month].split('-').map(&:to_i)
      start_date = Date.new(year, month)
      end_date = start_date.end_of_month
      @matches = Match.where(match_date: start_date..end_date).order(match_date: :asc)
      @month = start_date
      @q = Match.ransack(params[:q])
      render 'admin/matches/show_month'
    end

    private

    def set_match
      @match = Match.find(params[:id])
    end

    def match_params
      params.require(:match).permit(:match_date, :match_time, :event_id, :opponent, :stadium, :result, :team_score,
                                    :away_team_score)
    end
  end
end

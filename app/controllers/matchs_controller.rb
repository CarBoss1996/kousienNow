class MatchsController < ApplicationController
  def index
    @matches = Match.where(match_date: Date.today.beginning_of_day..Date.today.end_of_day)
  end

  def show
    @match = Match.find(params[:id])
  end
end

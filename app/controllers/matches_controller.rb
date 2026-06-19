class MatchesController < ApplicationController
  def index
    @matches = Match.includes(:home, :away).order(played_at: :desc)
  end
end

class MatchesController < ApplicationController
  def index
    @upcoming_matches = Match.with_users.where(played_at: [2.hours.ago..2.days.from_now]).order(:played_at).limit(3)
    @need_processing = Match.with_users.where.not(state: :completed).where(played_at: ..2.hours.ago).order(:played_at)
    @history = Match.with_users.completed.order(played_at: :desc)
  end
end

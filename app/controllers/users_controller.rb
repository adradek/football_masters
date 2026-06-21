class UsersController < ApplicationController
  # before_action :require_login

  def index
    @results = ResultsPresenter.new(users: User.includes(squads: :nations), current_user:)
    @actual_at = Match.data_actual_at
  end
end

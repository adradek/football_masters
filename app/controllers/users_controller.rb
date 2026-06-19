class UsersController < ApplicationController
  # before_action :require_login

  def index
    @users = User.includes(squads: :nations).order(:proposal)
    @actual_at = Match.data_actual_at
  end
end

class UsersController < ApplicationController
  # before_action :require_login

  def index
    @users = User.includes(squads: :nations).to_a.sort_by { |u| [-u.points, u.proposal] }
    @actual_at = Match.data_actual_at
  end
end

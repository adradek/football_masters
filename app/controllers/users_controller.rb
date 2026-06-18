class UsersController < ApplicationController
  before_action :require_login

  def index
    @users = User.includes(squads: :nations).order(:proposal)
  end
end

class UsersController < ApplicationController
  # before_action :require_login
  before_action :require_login, only: :toggle_shadows

  def index
    @results = results_presenter
    @actual_at = Match.data_actual_at
  end

  def toggle_shadows
    authorize current_user, :update?
    current_user.update!(show_shadows: !current_user.show_shadows?)

    @results = results_presenter
    @actual_at = Match.data_actual_at

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def results_presenter
    ResultsPresenter.new(users: User.includes(squads: :nations), current_user:)
  end
end

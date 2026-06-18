module Admin
  class SquadsController < BaseController
    before_action :set_user

    def index
      @squads = @user.squads.includes(:nations)
      authorize [:admin, Squad]
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end

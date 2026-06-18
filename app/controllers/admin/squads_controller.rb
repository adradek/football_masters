module Admin
  class SquadsController < BaseController
    before_action :set_user

    def index
      @squads = @user.squads.includes(:nations)
      authorize [:admin, Squad]
    end

    def new
      @squad = @user.squads.new
      authorize [:admin, @squad]
    end

    def create
      @squad = @user.squads.new(squad_params.except(:nations))
      authorize [:admin, @squad]

      result = SquadInspector.call(message: squad_params[:nations].to_s)

      if result.success?
        @squad.nations = result.value!
        @squad.save!
        redirect_to admin_user_squads_path(@user), notice: "Сквад создан."
      else
        redirect_to new_admin_user_squad_path(@user), alert: result.failure[:error_message]
      end
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end

    def squad_params
      params.require(:squad).permit(:description, :main, :nations)
    end
  end
end

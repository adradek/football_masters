module Admin
  class SquadChecksController < BaseController
    before_action :set_user

    def create
      @squad = @user.squads.new(squad_params.except(:nations))
      authorize [:admin, @squad], :create?

      @nations_message = squad_params[:nations].to_s
      result = SquadInspector.call(message: @nations_message)

      if result.success?
        @nations = result.value!
      else
        @error_message = result.failure[:error_message]
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

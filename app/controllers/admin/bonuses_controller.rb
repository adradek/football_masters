module Admin
  class BonusesController < BaseController
    before_action :set_match

    def new
      authorize [:admin, Bonus]
    end

    def create
      authorize [:admin, Bonus]

      result = Bonuses::Cashier.call(match: @match)

      if result.success?
        redirect_to pending_admin_matches_path, notice: "Бонусы начислены, матч обработан."
      else
        redirect_to new_admin_match_bonus_path(@match), alert: result.failure[:error_message]
      end
    end

    private

    def set_match
      @match = Match.find(params[:match_id])
    end
  end
end

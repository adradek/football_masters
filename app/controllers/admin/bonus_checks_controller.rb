module Admin
  class BonusChecksController < BaseController
    before_action :set_match

    def create
      authorize [:admin, Bonus], :create?

      result = Bonuses::SugarDaddy.call(match: @match)

      if result.success?
        @bonuses = result.value!
      else
        @error_message = result.failure[:error_message]
      end
    end

    private

    def set_match
      @match = Match.find(params[:match_id])
    end
  end
end

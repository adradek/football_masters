module Admin
  class VisitsController < BaseController
    def index
      authorize [:admin, Visit]

      @visits = VisitsAggregator.new
    end
  end
end

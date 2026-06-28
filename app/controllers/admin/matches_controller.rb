module Admin
  class MatchesController < BaseController
    def index
      @matches = Match.includes(:home, :away).order(played_at: :desc)
      authorize [:admin, Match]
    end

    def pending
      @matches = Match.includes(:home, :away).need_processing.order(:played_at)
      authorize [:admin, Match], :pending?
    end

    def new
      @match = Match.new(stage: :round_of_32)
      authorize [:admin, @match]
    end

    def edit
      @match = Match.find(params[:id])
      authorize [:admin, @match]
    end

    def update
      @match = Match.find(params[:id])
      authorize [:admin, @match]

      if @match.update(match_params)
        redirect_to admin_matches_path, notice: "Матч обновлён"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def create
      @match = Match.new(match_params)
      authorize [:admin, @match]

      if @match.save
        redirect_to admin_matches_path, notice: "Матч создан"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def match_params
      params.require(:match).permit(
        :home_id, :away_id, :played_at, :stage, :state,
        :score, :score_extra, :score_penalty
      )
    end
  end
end

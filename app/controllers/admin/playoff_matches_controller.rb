module Admin
  class PlayoffMatchesController < BaseController
    def new
      # TODO: replace hardcoded values
      @match = Match.new(stage: :eight_final, promotion_side: :no_side)
      authorize [:admin, @match], :create?
    end

    def options
      authorize [:admin, Match], :create?
      @stage = params[:stage].presence || "eight_final"
    end

    def create
      @match = Match.new(
        stage: playoff_params[:stage],
        played_at: playoff_params[:played_at],
        priority: playoff_params[:priority],
        promotion_side: playoff_params[:promotion_side]
      )
      authorize [:admin, @match], :create?

      Match.transaction do
        @match.save!
        assign_feeder(playoff_params[:home_feeder_id])
        assign_feeder(playoff_params[:away_feeder_id])
      end

      redirect_to admin_matches_path, notice: "Матч плей-офф собран"
    rescue ActiveRecord::RecordInvalid
      @stage = @match.stage
      render :new, status: :unprocessable_entity
    end

    private

    def assign_feeder(feeder_id)
      return if feeder_id.blank?

      Match.find(feeder_id).update!(promotion_game: @match)
    end

    def playoff_params
      params.require(:match).permit(
        :stage, :promotion_side, :played_at, :home_feeder_id, :away_feeder_id, :priority
      )
    end
  end
end

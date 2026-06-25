module Admin
  class BonusesController < BaseController
    before_action :set_match
    before_action :set_bonus, only: %i[edit update destroy]

    def index
      authorize [:admin, Bonus]
      @bonuses = @match.bonuses.includes(:nation).order(:created_at)
    end

    def new
      authorize [:admin, Bonus]
      @bonus = @match.bonuses.new(
        description: "Выход из группы #{@match.home.group.name[-1]} с  места"
      )
    end

    def create
      @bonus = @match.bonuses.new(bonus_params)
      authorize [:admin, @bonus]

      if save_and_recalculate(@bonus)
        redirect_to admin_match_bonuses_path(@match), notice: "Бонус добавлен"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      authorize [:admin, @bonus]
    end

    def update
      authorize [:admin, @bonus]

      @bonus.assign_attributes(bonus_params)

      if save_and_recalculate(@bonus)
        redirect_to admin_match_bonuses_path(@match), notice: "Бонус обновлён"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize [:admin, @bonus]

      nation = @bonus.nation

      ActiveRecord::Base.transaction do
        @bonus.destroy!
        recalculate_points(nation)
      end

      redirect_to admin_match_bonuses_path(@match), notice: "Бонус удалён"
    end

    # Автоматическая обработка матча — начисление всех бонусов разом (Cashier).
    def processing
      authorize [:admin, Bonus], :create?
    end

    def process_match
      authorize [:admin, Bonus], :create?

      result = Bonuses::Cashier.call(match: @match)

      if result.success?
        redirect_to pending_admin_matches_path, notice: "Бонусы начислены, матч обработан."
      else
        redirect_to processing_admin_match_bonuses_path(@match), alert: result.failure[:error_message]
      end
    end

    private

    def set_match
      @match = Match.find(params[:match_id])
    end

    def set_bonus
      @bonus = @match.bonuses.find(params[:id])
    end

    def bonus_params
      params.require(:bonus).permit(:nation_id, :reason, :value, :description)
    end

    def save_and_recalculate(bonus)
      ActiveRecord::Base.transaction do
        bonus.save!
        recalculate_points(bonus.nation)
      end
      true
    rescue ActiveRecord::RecordInvalid
      false
    end

    def recalculate_points(nation)
      nation.update!(points: nation.bonuses.sum(:value))
    end
  end
end

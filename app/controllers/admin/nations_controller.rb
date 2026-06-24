module Admin
  class NationsController < BaseController
    def index
      @nations = Nation.order(points: :desc, price: :asc, id: :asc)
      authorize [:admin, @nations]
    end

    def new
      @nation = Nation.new
      authorize [:admin, @nation]
    end

    def create
      @nation = Nation.new(nation_params)
      authorize [:admin, @nation]

      if @nation.save
        redirect_to admin_nations_path, notice: "Страна #{@nation.name} создана."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @nation = Nation.find(params[:id])
      authorize [:admin, @nation]
    end

    def update
      @nation = Nation.find(params[:id])
      authorize [:admin, @nation]

      if @nation.update(nation_params)
        redirect_to admin_nations_path, notice: "Страна #{@nation.name} обновлена."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def nation_params
      params.require(:nation).permit(:name, :flag_emoji, :normalized_name, :fifa_place, :fifa_rank, :points, :price, :leaved)
    end
  end
end

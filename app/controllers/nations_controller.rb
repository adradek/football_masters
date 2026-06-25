class NationsController < ApplicationController
  def index
    @nations = Nation.order(points: :desc, price: :asc, id: :asc).includes(squads: :user)

    @users = User.includes(squads: :nations).to_a.sort_by { |u| [-u.points, u.id] }

    # nation_id => [user_id, ...] — владельцы по основным (main) сквадам
    @owners_by_nation = Hash.new { |hash, key| hash[key] = [] }
    @users.each do |user|
      main_squad = user.squads.find(&:main?)
      next unless main_squad

      main_squad.nations.each { |nation| @owners_by_nation[nation.id] << user.id }
    end

    @actual_at = Match.data_actual_at
  end

  def show
    @nation = Nation.find(params[:id])
    @owners = @nation.squads.select(&:main?).map(&:user).sort_by(&:id)
    @matches = @nation.matches.with_users.order(played_at: :desc).to_a
    @bonuses = @nation.bonuses.includes(:match).order(created_at: :asc).references(:match)
    @actual_at = Match.data_actual_at
  end
end

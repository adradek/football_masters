module Admin
  class VisitsController < BaseController
    def index
      authorize [:admin, Visit]

      counts = Visit.group(:user_id).count
      @guest_count = counts.delete(nil) || 0

      users = User.where(id: counts.keys).index_by(&:id)
      @rows = counts
        .map { |user_id, count| [users[user_id], count] }
        .sort_by { |_user, count| -count }

      @total = @rows.sum { |_user, count| count } + @guest_count
    end
  end
end

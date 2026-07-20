class Visitor
  attr_reader :user, :visits

  def initialize(user:, visits: nil)
    @user = user
    @visits ||= (visits ||user.visits).sort_by(&:created_at)
  end

  def name
    user ? user.name : "Гость (без авторизации)"
  end

  def total_visits
    visits.size
  end

  def last_day_visits
    visits.select { |v| v.created_at >= 1.day.ago }.size
  end

  def last_visit
    visits.last&.created_at
  end
end

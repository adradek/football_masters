class VisitsAggregator < ApplicationService
  attr_reader :rows, :total, :guest_count

  def visitors
    @visitors ||= get_visitors
  end

  def total
    visitors.sum(&:total_visits)
  end

  private

  def get_visitors
    result = User
      .includes(:visits)
      .map { |user| Visitor.new(user:) }
      .reject { |v| v.total_visits.zero? }
      .sort_by { |v| -v.total_visits }
    result << Visitor.new(user: nil, visits: Visit.where(user_id: nil).order(:created_at).to_a)
  end
end

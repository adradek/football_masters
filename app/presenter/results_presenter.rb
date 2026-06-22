class ResultsPresenter
  attr_reader :users

  def initialize(users:, current_user:)
    @users = users
    @current_user = current_user
  end

  def each(...) = records.each(...)

  def records
    @records ||= prepare_records
  end

  private

  attr_reader :current_user

  def prepare_records
    users
      .map { |u| u.squads }
      .flatten
      .select { |squad| squad.main? || current_user&.show_shadows? }
      .map { |squad|  SquadRecord.new(squad:) }
      .sort_by { [-it.points, it.user.proposal] }
      .each_with_index { |record, i| record.place = i + 1 }
  end
end

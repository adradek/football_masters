class SquadRecord
  attr_reader :place, :squad

  def initialize(squad:)
    @squad = squad
  end

  def name
    return user.name if main?

    [user.name, squad.description].reject(&:blank?).join(" - ")
  end

  def nations
    @nations ||= squad.nations
  end

  def points
    @points ||= nations.sum(&:points)
  end

  def place=(place)
    @place = place
  end

  def percentil
    @percentil ||= Statistics.call(points)
  end

  def main?
    squad.main?
  end

  def color
    @color ||= user.color
  end

  def user
    @user ||= squad.user
  end

  def round_actual_matches
    nations.select do
      it.bonuses.any? { |b| b.reason != "promotion" && b.match.stage == Match::CURRENT_STAGE }
    end.size
  end

  def round_expected_matches
    nations.select do
      it.bonuses.any? { |b| b.reason == "promotion" && b.match.stage == Match::BEFORE_STAGE }
    end.size
  end

  def promoted_nations_number
    nations.select do
      it.bonuses.any? { |b| b.reason == "promotion" && b.match.stage == Match::CURRENT_STAGE }
    end.size
  end
end

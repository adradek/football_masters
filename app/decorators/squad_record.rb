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

  def main?
    squad.main?
  end

  def color
    @color ||= user.color
  end

  def user
    @user ||= squad.user
  end
end

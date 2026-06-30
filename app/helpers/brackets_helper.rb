module BracketsHelper
  ROUND_LABELS = {
    "round_of_32" => "1/16 финала",
    "eight_final" => "1/8 финала",
    "quarter_final" => "1/4 финала",
    "semi_final" => "1/2 финала",
    "final" => "Финал",
    "third_place" => "Матч за 3-е место"
  }.freeze

  ROUND_LABELS_SHORT = {
    "round_of_32" => "1/16",
    "eight_final" => "1/8",
    "quarter_final" => "1/4",
    "semi_final" => "1/2",
    "final" => "Финал",
    "third_place" => "3-е место"
  }.freeze

  def bracket_round_label(stage, short: false)
    (short ? ROUND_LABELS_SHORT : ROUND_LABELS).fetch(stage, stage)
  end

  # Голы конкретной стороны из основного счёта ("2:1" → "2" / "1").
  def bracket_team_goals(match, side)
    return if match&.score.blank?

    goals = match.score.split(/[:\-]/).map(&:strip)
    side == :home ? goals[0] : goals[1]
  end

  # Приписка про доп. время / серию пенальти под карточкой.
  def bracket_match_note(match)
    return if match.nil?

    if match.score_penalty.present?
      "пен. #{match.score_penalty}"
    elsif match.score_extra.present?
      "д.в. #{match.score_extra}"
    end
  end
end

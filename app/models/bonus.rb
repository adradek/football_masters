class Bonus < ApplicationRecord
  belongs_to :match
  belongs_to :nation

  validates :match, presence: true
  validates :nation, presence: true
  validates :nation, uniqueness: { scope: [:match_id, :reason] }
  validates :value, presence: true

  enum :reason, {
    defeat: 0,
    draw: 1,
    victory: 2,
    defeat_extra_time: 5,
    victory_extra_time: 3,
    defeat_penalty: 6,
    victory_penalty: 7,
    promotion: 4
  }

  REASON_LABELS = {
    "defeat" => "Поражение",
    "draw" => "Ничья",
    "victory" => "Победа",
    "defeat_extra_time" => "Поражение в доп. время",
    "victory_extra_time" => "Победа в доп. время",
    "defeat_penalty" => "Поражение в серии пенальти",
    "victory_penalty" => "Победа в серии пенальти",
    "promotion" => "Проход дальше"
  }.freeze

  def self.reason_labels
    REASON_LABELS
  end

  def reason_label
    REASON_LABELS.fetch(reason, reason&.humanize)
  end
end

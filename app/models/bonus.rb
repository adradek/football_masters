class Bonus < ApplicationRecord
  belongs_to :match
  belongs_to :nation

  validates :match, presence: true
  validates :nation, presence: true
  validates :nation, uniqueness: { scope: [:match_id, :reason] }
  validates :value, presence: true

  enum :reason, { defeat: 0, draw: 1, victory: 2, victory_extra_time: 3, promotion: 4 }

  REASON_LABELS = {
    "defeat" => "Поражение",
    "draw" => "Ничья",
    "victory" => "Победа",
    "victory_extra_time" => "Победа в доп. время",
    "promotion" => "Проход дальше"
  }.freeze

  def self.reason_labels
    REASON_LABELS
  end

  def reason_label
    REASON_LABELS.fetch(reason, reason&.humanize)
  end
end

class Match < ApplicationRecord
  belongs_to :home, class_name: "Nation"
  belongs_to :away, class_name: "Nation"

  validates :played_at, presence: true
  validate :home_and_away_differ

  scope :need_processing, -> {
    where.not(state: :completed).where(played_at: ..2.hours.ago)
  }

  enum :stage, {
    group_round: 0,
    round_of_16: 1,
    eight_final: 2,
    quarter_final: 3,
    semi_final: 4,
    third_place: 5,
    final: 6
  }

  enum :state, { not_started: 0, live: 1, finished: 2, completed: 3 }

  private

  def home_and_away_differ
    return if home_id.blank? || away_id.blank?

    errors.add(:away_id, "не может совпадать с командой хозяев") if home_id == away_id
  end
end

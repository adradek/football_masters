class Match < ApplicationRecord
  # TODO: move this to a service
  CHAMPIONSHIP_START = Time.zone.local(2026, 6, 11, 22, 0)

  belongs_to :home, class_name: "Nation", optional: true
  belongs_to :away, class_name: "Nation", optional: true

  validates :played_at, presence: true
  validate :home_and_away_differ

  scope :need_processing, -> {
    where.not(state: :completed).where(played_at: ..2.hours.ago)
  }

  enum :stage, {
    group_round: 0,
    round_of_32: 1,
    eight_final: 2,
    quarter_final: 3,
    semi_final: 4,
    third_place: 5,
    final: 6
  }

  enum :state, { not_started: 0, live: 1, finished: 2, completed: 3 }

  # TODO: move this to a service
  def self.data_actual_at
    last_completed_at = completed.maximum(:played_at)
    last_completed_at ? last_completed_at + 2.hours : CHAMPIONSHIP_START
  end

  def need_processing?
    !completed? && played_at < 2.hours.ago
  end

  private

  def home_and_away_differ
    return if home_id.blank? || away_id.blank?

    errors.add(:away_id, "не может совпадать с командой хозяев") if home_id == away_id
  end
end

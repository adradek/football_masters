class Match < ApplicationRecord
  # TODO: move this to a service
  CHAMPIONSHIP_START = Time.zone.local(2026, 6, 11, 22, 0)
  CURRENT_STAGE = "round_of_32".freeze

  belongs_to :home, class_name: "Nation", optional: true
  belongs_to :away, class_name: "Nation", optional: true
  belongs_to :promotion_game, class_name: "Match", optional: true, inverse_of: :feeders

  # Матчи предыдущей стадии, победители которых проходят в этот матч.
  has_many :feeders, class_name: "Match", foreign_key: :promotion_game_id,
                     inverse_of: :promotion_game, dependent: :nullify

  has_many :bonuses

  validates :played_at, presence: true
  validate :home_and_away_differ

  scope :need_processing, -> {
    where.not(state: :completed).where(played_at: ..2.hours.ago)
  }

  scope :with_users, -> { includes(home: { squads: :user }, away: { squads: :user }) }

  enum :promotion_side, { no_side: 0, home_side: 1, away_side: 2 }

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

  # Стадия плей-офф, из которой берутся матчи-поставщики для данной стадии.
  PREVIOUS_STAGE = {
    "eight_final" => "round_of_32",
    "quarter_final" => "eight_final",
    "semi_final" => "quarter_final",
    "third_place" => "semi_final",
    "final" => "semi_final"
  }.freeze

  # Кандидаты в поставщики команды на сторону side для собираемого матча стадии stage:
  # матчи предыдущей стадии с нужной promotion_side, ещё не привязанные к матчу-проходу.
  scope :promotion_candidates_for, ->(stage, side) {
    previous = PREVIOUS_STAGE[stage.to_s]
    next none if previous.blank?

    where(stage: previous, promotion_side: side, promotion_game_id: nil).order(:played_at)
  }

  def self.previous_stage(stage)
    PREVIOUS_STAGE[stage.to_s]
  end

  # Текстовая подпись матча для выпадающих списков сборки плей-офф.
  def promotion_label
    teams = "#{home&.name_with_flag || "?"} - #{away&.name_with_flag || "?"}"
    "(##{id}) #{teams}"
  end

  # TODO: move this to a service
  def self.data_actual_at
    last_completed_at = completed.maximum(:played_at)
    last_completed_at ? last_completed_at + 2.hours : CHAMPIONSHIP_START
  end

  def need_processing?
    !completed? && played_at < 2.hours.ago
  end

  # Сторона-победитель (:home / :away) с учётом доп. времени и пенальти.
  # nil, если матч не сыгран или закончился вничью без серии пенальти.
  def winner_side
    decisive = [ score_penalty, score_extra, score ].map(&:presence).compact.first
    return if decisive.blank?

    home_goals, away_goals = decisive.split(/[:\-]/).map { |part| part.strip.to_i }
    return :home if home_goals > away_goals
    return :away if away_goals > home_goals

    nil
  end

  def winner
    case winner_side
    when :home then home
    when :away then away
    end
  end

  private

  def home_and_away_differ
    return if home_id.blank? || away_id.blank?

    errors.add(:away_id, "не может совпадать с командой хозяев") if home_id == away_id
  end
end

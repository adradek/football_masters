class Bonus < ApplicationRecord
  belongs_to :match
  belongs_to :nation

  validates :match, presence: true
  validates :nation, presence: true
  validates :nation, uniqueness: { scope: :match_id }
  validates :value, presence: true

  enum :reason, { defeat: 0, draw: 1, victory: 2, victory_extra_time: 3, promotion: 4 }
end

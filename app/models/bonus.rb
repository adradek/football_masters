class Bonus < ApplicationRecord
  belongs_to :match
  belongs_to :nation

  validates :match, presence: true
  validates :nation, presence: true
  validates :nation, uniqueness: { scope: :match_id }
  validates :value, presence: true
end

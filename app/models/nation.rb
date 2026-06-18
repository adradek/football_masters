class Nation < ApplicationRecord
  validates :name, presence: true

  has_and_belongs_to_many :squads
end

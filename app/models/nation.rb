class Nation < ApplicationRecord
  validates :name, presence: true
end

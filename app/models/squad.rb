class Squad < ApplicationRecord
  belongs_to :user

  validates :main, uniqueness: { scope: :user_id }, if: :main?
end

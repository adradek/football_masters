class Squad < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :nations

  validates :main, uniqueness: { scope: :user_id }, if: :main?
end

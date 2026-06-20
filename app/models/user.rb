class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :secret, presence: true, uniqueness: true

  has_many :squads
  has_one :main_squad, -> { main }, class_name: "Squad"

  enum :role, { member: 0, admin: 1, viewer: 2, superadmin: 3 }, default: :member

  def admin_access?
    admin? || superadmin?
  end

  def points
    squads.find(&:main?)&.nations&.sum(:points) || 0
  end
end

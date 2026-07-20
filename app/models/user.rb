class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :secret, presence: true, uniqueness: true

  has_many :squads
  has_many :visits
  has_one :main_squad, -> { main }, class_name: "Squad"

  enum :role, { member: 0, admin: 1, viewer: 2, superadmin: 3 }, default: :member

  def admin_access?
    admin? || superadmin?
  end

  def points
    squads.find(&:main?)&.nations&.sum(:points) || 0
  end

  def knows_about_shadows?
    # admin_access? || squads.exists?(main: false)
    true
  end

  def initials
    parts = name.to_s.split(/[\s_-]+/).reject(&:blank?)

    if parts.size >= 2
      (parts.first[0].to_s + parts.last[0].to_s).upcase
    else
      name.to_s[0].upcase
    end
  end
end

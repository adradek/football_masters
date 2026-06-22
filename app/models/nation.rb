class Nation < ApplicationRecord
  validates :name, presence: true

  has_many :bonuses
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :squads

  def group
    @group ||= groups.first
  end

  def matches
    @matches ||= Match.where(home: self).or(Match.where(away: self))
  end

  def name_with_price
    "#{name} (#{price})"
  end

  def name_with_flag
    "#{flag_emoji} #{name}"
  end

  def reload(options = nil)
    @group = nil
    @matches = nil
    super
  end
end

class Nation < ApplicationRecord
  validates :name, presence: true

  has_and_belongs_to_many :squads

  def name_with_price
    "#{name} (#{price})"
  end

  def name_with_flag
    "#{flag_emoji} #{name}"
  end
end

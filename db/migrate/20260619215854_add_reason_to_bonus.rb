class AddReasonToBonus < ActiveRecord::Migration[8.1]
  def change
    add_column :bonuses, :reason, :integer, null: false, default: 0
  end
end

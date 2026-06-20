class AddPointsToNation < ActiveRecord::Migration[8.1]
  def change
    add_column :nations, :points, :integer, null: false, default: 0
  end
end

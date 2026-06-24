class AddLeavedToNation < ActiveRecord::Migration[8.1]
  def change
    add_column :nations, :leaved, :boolean, null: false, default: false
  end
end

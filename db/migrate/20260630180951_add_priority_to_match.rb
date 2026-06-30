class AddPriorityToMatch < ActiveRecord::Migration[8.1]
  def change
    add_column :matches, :priority, :integer, null: false, default: 1000
  end
end

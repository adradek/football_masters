class AddPriceToNation < ActiveRecord::Migration[8.1]
  def change
    add_column :nations, :price, :integer, null: false, default: 0
  end
end

class AddPromotionGameToMatch < ActiveRecord::Migration[8.1]
  def change
    add_reference :matches, :promotion_game, null: true, foreign_key: { to_table: :matches }
    add_column :matches, :promotion_side, :integer, null: false, default: 0
  end
end

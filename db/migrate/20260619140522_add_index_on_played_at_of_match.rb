class AddIndexOnPlayedAtOfMatch < ActiveRecord::Migration[8.1]
  def change
    add_index :matches, :played_at
  end
end

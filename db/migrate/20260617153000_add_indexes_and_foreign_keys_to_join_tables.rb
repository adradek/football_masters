class AddIndexesAndForeignKeysToJoinTables < ActiveRecord::Migration[8.1]
  def change
    add_index :groups_nations, [:group_id, :nation_id], unique: true
    add_index :groups_nations, :nation_id
    add_foreign_key :groups_nations, :groups
    add_foreign_key :groups_nations, :nations
  end
end

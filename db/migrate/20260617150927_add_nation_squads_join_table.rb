class AddNationSquadsJoinTable < ActiveRecord::Migration[8.1]
  def change
    create_join_table :nations, :squads, column_options: { type: :bigint, null: false } do |t|
      t.index [:nation_id, :squad_id], unique: true
      t.index :squad_id
      t.foreign_key :nations
      t.foreign_key :squads
    end
  end
end

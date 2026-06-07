class CreateNations < ActiveRecord::Migration[8.1]
  def change
    create_table :nations do |t|
      t.string :name, null: false
      t.integer :fifa_rank, null: false
      t.integer :fifa_place, null: false
      t.string :flag_emoji, null: false

      t.timestamps
    end
  end
end

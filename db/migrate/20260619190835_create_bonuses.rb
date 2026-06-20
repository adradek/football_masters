class CreateBonuses < ActiveRecord::Migration[8.1]
  def change
    create_table :bonuses do |t|
      t.references :match, null: false, foreign_key: true
      t.references :nation, null: false, foreign_key: true
      t.integer :value, null: false, default: 0
      t.string :description

      t.timestamps
    end
  end
end

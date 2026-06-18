class CreateSquads < ActiveRecord::Migration[8.1]
  def change
    create_table :squads do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :main, null: false, default: false
      t.string :description

      t.timestamps
    end
  end
end

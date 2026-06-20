class CreateMatches < ActiveRecord::Migration[8.1]
  def change
    create_table :matches do |t|
      t.integer :stage, null: false, default: 0
      t.datetime :played_at
      t.references :home, foreign_key: { to_table: :nations }
      t.references :away, foreign_key: { to_table: :nations }
      t.string :score
      t.string :score_extra
      t.string :score_penalty
      t.integer :state, null: false, default: 0

      t.timestamps
    end
  end
end

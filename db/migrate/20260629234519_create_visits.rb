class CreateVisits < ActiveRecord::Migration[8.1]
  def change
    create_table :visits do |t|
      t.references :user, null: true, foreign_key: true
      t.string :ip
      t.string :controller
      t.string :action

      t.datetime :created_at, null: false
    end

    add_index :visits, :created_at
  end
end

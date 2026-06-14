class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :secret, null: false
      t.string :color

      t.timestamps
    end

    add_index :users, :name, unique: true
    add_index :users, :secret, unique: true
  end
end

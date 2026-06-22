class AddMoneyBallToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :money_ball, :boolean, null: false, default: false
  end
end

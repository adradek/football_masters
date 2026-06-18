class AddRestrictiveIndexToSquad < ActiveRecord::Migration[8.1]
  def change
    add_index :squads, :user_id, unique: true, where: "main = true", name: "index_squads_on_user_id_main_unique"
  end
end

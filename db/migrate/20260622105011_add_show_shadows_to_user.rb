class AddShowShadowsToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :show_shadows, :boolean, null: false, default: false
  end
end

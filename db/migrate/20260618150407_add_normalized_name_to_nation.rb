class AddNormalizedNameToNation < ActiveRecord::Migration[8.1]
  def change
    add_column :nations, :normalized_name, :string
  end
end

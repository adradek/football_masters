class CreateJoinTableGroupsNations < ActiveRecord::Migration[8.1]
  def change
    create_join_table :groups, :nations do |t|
      # t.index [:group_id, :nation_id]
      # t.index [:nation_id, :group_id]
    end
  end
end

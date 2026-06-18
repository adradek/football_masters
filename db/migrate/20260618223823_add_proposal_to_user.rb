class AddProposalToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :proposal, :integer
    add_index :users, :proposal
  end
end

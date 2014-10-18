class AddVotesToNik < ActiveRecord::Migration
  def change
    add_column :niks, :votes, :integer, default: 0
  end
end

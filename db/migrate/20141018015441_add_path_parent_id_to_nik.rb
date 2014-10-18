class AddPathParentIdToNik < ActiveRecord::Migration
  def change
    add_column :niks, :parent_id, :integer
    add_column :niks, :path, :ltree
  end
end

class CreateBranchWeights < ActiveRecord::Migration
  def change
    create_table :branch_weights do |t|
      t.integer :story_id
      t.ltree :path
      t.integer :weight

      t.timestamps
    end
  end
end

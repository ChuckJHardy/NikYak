class AddLtreeExtension < ActiveRecord::Migration
  def change
    execute("CREATE EXTENSION ltree")
  end
end

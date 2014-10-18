class AddPrivateFlagToNik < ActiveRecord::Migration
  def change
    add_column :niks, :private_flag, :boolean, default: false
  end
end

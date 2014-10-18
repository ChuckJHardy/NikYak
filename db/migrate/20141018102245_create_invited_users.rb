class CreateInvitedUsers < ActiveRecord::Migration
  def change
    create_table :invited_users do |t|
      t.integer :users_id
      t.integer :story_id

      t.timestamps
    end
  end
end

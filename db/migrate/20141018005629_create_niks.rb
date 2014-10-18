class CreateNiks < ActiveRecord::Migration
  def change
    create_table :niks do |t|
      t.string :title
      t.text :body
      t.integer :limit
      t.references :user, index: true

      t.timestamps
    end
  end
end

class CreateYaks < ActiveRecord::Migration
  def change
    create_table :yaks do |t|
      t.text :body
      t.references :nik, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end

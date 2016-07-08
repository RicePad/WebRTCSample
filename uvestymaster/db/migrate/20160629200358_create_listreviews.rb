class CreateListreviews < ActiveRecord::Migration
  def change
    create_table :listreviews do |t|
      t.integer :rating
      t.text :comment

      t.timestamps null: false
    end
  end
end

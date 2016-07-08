class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :address
      t.string :city
      t.string :state
      t.timestamps null: false
    end
  end
end

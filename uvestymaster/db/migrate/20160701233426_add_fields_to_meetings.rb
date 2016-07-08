class AddFieldsToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :buyer_id, :integer
    add_column :meetings, :seller_id, :integer
  end
end

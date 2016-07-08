class AddUserIdToListreviews < ActiveRecord::Migration
  def change
    add_column :listreviews, :user_id, :integer
  end
end

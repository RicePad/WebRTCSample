class AddUserIdToMentorings < ActiveRecord::Migration
  def change
    add_column :mentorings, :user_id, :integer
  end
end

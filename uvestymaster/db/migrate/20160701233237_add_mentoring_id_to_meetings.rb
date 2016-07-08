class AddMentoringIdToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :mentoring_id, :integer
  end
end

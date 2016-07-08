class AddZoomusHostIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :host_id, :string
  end
end

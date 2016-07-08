class AddCreditToUsers < ActiveRecord::Migration
  def change
    add_column :users, :card, :string
    add_column :users, :cvv, :string
    add_column :users, :expmonth, :string
    add_column :users, :expyear, :string
  end
end

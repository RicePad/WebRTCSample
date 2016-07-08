class AddBankingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :routing, :string
    add_column :users, :account, :string
    add_column :users, :country, :string
  end
end

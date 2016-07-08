class AddListingIdToListreviews < ActiveRecord::Migration
  def change
    add_column :listreviews, :listing_id, :integer
  end
end

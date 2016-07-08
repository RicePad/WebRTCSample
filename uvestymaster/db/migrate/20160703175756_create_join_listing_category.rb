class CreateJoinListingCategory < ActiveRecord::Migration
  def change
    create_table :join_listing_categories do |t|
      t.integer :listing_id
      t.integer :listing_category_id
    end
  end
end

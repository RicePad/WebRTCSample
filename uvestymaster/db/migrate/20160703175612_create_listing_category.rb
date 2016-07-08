class CreateListingCategory < ActiveRecord::Migration
  def change
    create_table :listing_categories do |t|
      t.string :name
    end
  end
end

class ListingCategory < ActiveRecord::Base
     #jonathan
  has_many :join_listing_categories
  has_many :listings, through: :join_listing_categories




end
class JoinListingCategory < ActiveRecord::Base
  #jonathan
  belongs_to :listing
  belongs_to :listingcategory

end

class Listreview < ActiveRecord::Base
#validates :list_id, uniqueness: {scope: :user_id, message: ":You have already reviewed this."}
    belongs_to :listing
    belongs_to :user

end

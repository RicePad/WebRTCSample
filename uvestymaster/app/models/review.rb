class Review < ActiveRecord::Base
    validates :user_id, uniqueness: {scope: :user_id, message: ":You have already reviewed this."}
    belongs_to :user


end
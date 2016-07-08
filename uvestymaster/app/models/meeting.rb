class Meeting < ActiveRecord::Base
  validates :address, :city, :state, presence: true
  #menotoring association
  belongs_to :mentoring

  #universial association to mentorings and listings
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"
end

class Listing < ActiveRecord::Base

  if Rails.env.development?
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg"
  else
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg",
                      :storage => :dropbox,
                      :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                      :path => ":style/:id_:filename"
  end
  #requirments
  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates_attachment_presence :image
  #Paperclip
  has_attached_file :image, :styles => { :medium => "300x300#", :small => "100x100#", :perfect => "150x150!" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  #associations
  belongs_to :user
  has_many :orders
#  has_many :reviews


 #jonathan: listing associatoins
   has_many :join_listing_categories
  # has_many :listings, through: :join_listing_categories



end
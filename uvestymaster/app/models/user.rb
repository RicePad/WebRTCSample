class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  #sessions page associationg (it's called Comments though!)
  has_many :comments, dependent: :delete_all

  #mentorings page for users
  validates :name, presence: true
  has_many :mentorings, dependent: :destroy
  has_many :sales, class_name: "Meeting", foreign_key: "seller_id"
  has_many :purchases, class_name: "Meeting", foreign_key: "buyer_id"


  #listings page for video courses
  validates :name, presence: true
  has_many :listings, dependent: :destroy
  has_many :sales, class_name: "Order", foreign_key: "seller_id"
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"

  #zoomus (1 of 3)
  after_create :generate_zoom_id
  before_destroy :remove_zoom_user

  #zoomus creating account (2 of 3)
  def generate_zoom_id
    zoomus_client = Zoomus.new
    new_user = zoomus_client.user_create(email: self.email, type: 1)
    self.update_attributes(host_id: new_user['id'])
  end

  #zoomus deleting account (3 of 3)
  def remove
  zoomus_client = Zoomus.new
  zoomus_client.user_delete(id: self.zoom_id)
  end

  #Categories association
  has_many :user_categories
  has_many :categories, through: :user_categories

  #user and list review associations
  has_many :reviews
  has_many :listreviews

  #Mailboxer
  acts_as_messageable
  def mailboxer_email(object)
    email
  end

  #Paperclip Images
  has_attached_file :avatar,
  :styles => { :medium => "300x300#", :small => "100x100#", :perfect => "150x150!", :navigationsmall => "30x30!" }, default_url: "https://s32.postimg.org/583oy6lqd/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  #Paperclip Videos
    has_attached_file :video,
    :styles => {
    :medium => { :geometry => "640x480", :format => 'flv' },
    :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10 }
  }, :processors => [:transcoder]

  #video (panda)
  has_many :videos
end
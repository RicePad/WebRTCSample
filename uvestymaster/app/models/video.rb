class Video < ActiveRecord::Base
  #association to user
  belongs_to :user

  #Video Validation
  validates_presence_of :panda_video_id

  #panda_video method to find videos?
  def panda_video
    @panda_video ||= Panda::Video.find(panda_video_id)
  end
end

class ZoomController < ApplicationController
  require 'zoomus'

  def index
  end

  def create
    zoomus_client = Zoomus.new
    meeting = zoomus_client.meeting_create(host_id: 'dWkVNB2tQvic4YcPYK6tDA', topic: 'topic1', type: 1)
    redirect_to meeting["start_url"]
   # UserMailer.send_link_to(email: params[:email], link: @url)
  end



  #def current_user
  #  {zoom_id: 'dWkVNB2tQvic4YcPYK6tDA'}
  #end

end



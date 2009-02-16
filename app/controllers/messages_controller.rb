class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def create
    @messages = Message.new(params[:message])
    @messages.save
    render :juggernaut do |page|
      page["ul#messages"].prepend "<li>#{h @messages.content}</li>"
    end
    render :nothing => true
  end
end

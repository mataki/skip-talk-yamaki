class MessagesController < ApplicationController
  before_filter :login_required

  def index
    @messages = Message.all
  end

  def create
    @messages = Message.new(params[:message])
    if @messages.save
      render :juggernaut do |page|
        page["ul#messages"].prepend "<li>#{h @messages.content}</li>"
      end
    else
      render :juggernaut do |page|
        page.alert("not saved")
      end
    end
    render :nothing => true
  end
end

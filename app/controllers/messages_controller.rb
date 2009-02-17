class MessagesController < ApplicationController
  before_filter :login_required

  include MessagesHelper

  def index
    @messages = requested_room.messages.all
  end

  def create
    @messages = requested_room.messages.build(params[:message].merge(:user => current_user))
    if @messages.save
      render :juggernaut => { :type => :send_to_channel, :channel => [requested_room.id] } do |page|
        page["ul#messages"].prepend show_message(@messages)
      end
    else
      render :juggernaut => { :type => :send_to_client, :client_id => current_user.id } do |page|
        page.alert("not saved")
      end
    end
    render :nothing => true
  end
end

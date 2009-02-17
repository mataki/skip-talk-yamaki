class MessagesController < ApplicationController
  before_filter :login_required

  include MessagesHelper

  def index
    @messages = Message.all
  end

  def create
    @messages = Message.new(params[:message].merge(:user => current_user))
    if @messages.save
      render :juggernaut do |page|
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

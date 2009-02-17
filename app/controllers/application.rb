# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password, :authenticity_token, :token
  layout 'application'
  include AuthenticatedSystem
  helper_method :requested_room

  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

  protected
  def render_not_found(e = nil)
    e.backtrace.each{|m| logger.debug m } if e
    render :template => "shared/not_found", :status => :not_found, :layout => false
  end

  def requested_room
    @room if defined?(@room)
    @room = Room.accessible(self.current_user).find(params[:room_id])
  end
end

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password, :authenticity_token, :token
  layout 'application'
  include AuthenticatedSystem
  helper_method :requested_room

  protected
  def requested_room
    @room if defined?(@room)
    @room = Room.find(params[:room_id])
  end
end

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def juggernaut_with_session
    if logged_in?
      if params[:room_id] && requested_room
        juggernaut(:channels => [requested_room.id], :client_id => current_user.id)
      else
        juggernaut(:client_id => current_user.id)
      end
    else
      juggernaut
    end
  end
end

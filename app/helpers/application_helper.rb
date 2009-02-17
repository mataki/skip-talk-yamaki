# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def juggernaut_with_session
    if logged_in?
      juggernaut(:client_id => current_user.id)
    else
      juggernaut
    end
  end
end

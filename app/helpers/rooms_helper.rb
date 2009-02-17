module RoomsHelper
  def show_attendee(users)
    html = ["<ul>"]
    users.each do |user|
      html << "<li>#{user.login}</li>"
    end
    html << "</ul>"
    html.join('')
  end
end

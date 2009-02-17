module MessagesHelper
  def show_message(message)
    "<li>#{message.user.login}: #{message.content}</li>"
  end
end

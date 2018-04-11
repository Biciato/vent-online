class MessageBroadcastJob < ApplicationJob
  queue_as :default

  # send the chat message to the channel to appear on the page
  def perform(data)
    user = User.find(data["user_id"])
    ActionCable.server.broadcast 'chat_channel', content:  data["content"], username: user.email, id: user.id
  end
end

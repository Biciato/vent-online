class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
    user = User.find(data["user_id"])
    ActionCable.server.broadcast 'chat_channel', content:  data["content"], username: user.email, id: user.id
  end
end

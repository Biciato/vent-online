class BlockUserJob < ApplicationJob
  queue_as :default

  def perform(data)
    User.find(data["user_id"]).update(status: false, online: false)
    ActionCable.server.broadcast 'chat_channel', content: "qwertyuiop"
  end
end

class BlockUserJob < ApplicationJob
  queue_as :default

  # updates status and online attribute on the db to false and shows the user's email on the page only to the admin
  def perform(data)
    User.find(data["user_id"]).update(status: false, online: false)
    ActionCable.server.broadcast 'chat_channel', content: "qwertyuiop"
  end
end

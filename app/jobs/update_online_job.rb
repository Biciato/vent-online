class UpdateOnlineJob < ApplicationJob
  queue_as :default

  # updates the user's online attribute to false
  def perform(data)
    User.find(data["user_id"]).update(online: false)
  end
end

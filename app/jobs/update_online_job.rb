class UpdateOnlineJob < ApplicationJob
  queue_as :default

  def perform(data)
    User.find(data["user_id"]).update(online: false)
  end
end

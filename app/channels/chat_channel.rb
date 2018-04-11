class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # called by chat channel when the user send a message via chat
  def speak(data)
    MessageBroadcastJob.perform_later data
  end

  # called by chat channel when the admin clicks on direct-user button
  def block_user(data)
    BlockUserJob.perform_later data
  end

  # called by chat channel when the admin clicks on update_online button
  def update_online(data)
    UpdateOnlineJob.perform_later data
  end
end

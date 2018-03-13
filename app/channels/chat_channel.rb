class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  def speak(data)
    MessageBroadcastJob.perform_later data
  end
  
  def block_user(data)
    BlockUserJob.perform_later data
  end
  
  def update_online(data)
    UpdateOnlineJob.perform_later data
  end
end

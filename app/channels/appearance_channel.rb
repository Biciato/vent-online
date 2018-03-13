class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appearance_channel"
    ActionCable.server.broadcast 'appearance_channel', current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

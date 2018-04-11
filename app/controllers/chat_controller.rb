class ChatController < ApplicationController

  def room
    # checks if the user is online, e.g. the online attribute is true on the db. If it's not, redirect_to
    # to the root 
    if current_user.online_check
      redirect_to root_path
    else
      current_user.online!
    end
  end
end

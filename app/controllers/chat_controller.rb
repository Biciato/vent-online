class ChatController < ApplicationController
   
  def room
    if current_user.online_check
      redirect_to root_path
    else
      current_user.online!
    end
  end
end

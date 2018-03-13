class ChatController < ApplicationController
    before_action :check_online 
    
    def room
      
    end
    
    private
    
      def check_online
        redirect_to root_path if User.where(online: true).count > 0
      end
     
end

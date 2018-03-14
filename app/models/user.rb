class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def online!
    unless self.admin
      self.online =true
      self.save
    end
  end
  
  def online_check
    User.where(online: true).count == 1
  end
  
  
  
  
  
end

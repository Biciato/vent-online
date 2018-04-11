class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # updates the online attribute to true on the db
  def online!
    unless self.admin
      self.online =true
      self.save
    end
  end

  # checks the quantity of users that is online, e.g. how many users that have the attribute
  # online as true on the db. If it's equals to 1, he can access the chat, if it's not,
  # the user can't access the chat. 
  def online_check
    User.where(online: true).count == 1
  end





end

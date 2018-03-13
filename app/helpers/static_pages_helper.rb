module StaticPagesHelper
  def admin?
    current_user.admin if current_user
  end
  
  def status_ok?
    current_user.status if current_user
  end
  
  def online_check
    User.where(online: true).count == 2
  end
end

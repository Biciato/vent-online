module StaticPagesHelper

  # checks if the user is an admin
  def admin?
    current_user.admin if current_user
  end

  # checks if the user status is true, e.g. if the status attribute is true on the db
  def status_ok?
    current_user.status if current_user
  end

  # checks if the user is online, e.g. if the online attribute is true on the db
  def online_check
    User.where(online: true).count == 2
  end
end

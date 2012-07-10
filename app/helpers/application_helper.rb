module ApplicationHelper
  
  def current_user_name
    current_user.email
  end
  
end

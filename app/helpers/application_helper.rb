module ApplicationHelper
  def user_can_add_yak?(nik)
    current_user != nik.user
  end
end

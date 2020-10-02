module UsersHelper
  def user_new_or_edit
    if action_name == 'new' || action_name == 'create'
      users_path
    elsif action_name == 'edit' || action_name == 'update'
      user_path
    end
  end

  def user_submit_button_value
    if action_name == 'new' || action_name == 'create'
      "Create your account"
    elsif action_name == "edit" || action_name == 'update'
      "Update your account"
    end
  end
end

module BlogsHelper
  def choose_index_or_edit
    if action_name == 'index' || action_name == 'create' || action_name == 'confirm'
      confirm_blogs_path
    elsif action_name == 'edit' || action_name == 'update'
      blog_path
    end
  end

  def submit_button_value
    if action_name == 'index' || action_name == 'create' || action_name == 'confirm'
      "確認画面へ"
    elsif action_name == 'edit' || action_name == 'update'
      "投稿する"
    end
  end
end

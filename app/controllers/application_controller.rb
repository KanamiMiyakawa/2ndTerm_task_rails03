class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user
    if current_user == nil
      flash[:alert] = t('notice.login_needed')
      redirect_to new_session_path
    end
  end

  def fobid_login_user
    if current_user
      flash[:alert] = "すでにログインしています"
      redirect_to blogs_path
    end
  end
end

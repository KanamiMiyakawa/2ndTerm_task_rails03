class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :favorites]
  before_action :fobid_login_user, only: [:new, :create]
  before_action :authenticate_user, only: [:show, :edit, :update, :favorites]
  before_action :user_different, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path(@user.id), notice: 'ユーザー登録が完了しました！'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'ユーザー情報を更新しました！'
    else
      render :edit
    end
  end

  def favorites
    @favorite_blogs = @user.favorite_blogs
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :image, :image_cache, :password, :password_confirmation)
  end

  def user_different
    @user = User.find(params[:id])
    if current_user.id != @user.id
      flash[:alert] = "他のユーザーの情報は編集できません"
      redirect_to blogs_path
    end
  end
end

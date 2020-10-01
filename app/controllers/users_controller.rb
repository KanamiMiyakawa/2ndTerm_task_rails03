class UsersController < ApplicationController

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
    @user = User.find(params[:id])
  end

  def favorites
    @user = User.find(params[:id])
    @blogs = @user.favorite_blogs
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :image_cache, :password, :password_confirmation)
  end
end

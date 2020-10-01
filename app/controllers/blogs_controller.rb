class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:index, :show, :new, :edit]
  before_action :different_user, only: [:edit, :update, :destroy]

  def index
    @blogs = Blog.all.order("id DESC")
    @blog = Blog.new
  end

  def show
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    @blogs = Blog.all.order("id DESC")
    render :index if @blog.invalid?
  end

  def edit
  end

  def create
    @blogs = Blog.all.order("id DESC")
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :index
    else
      if @blog.save
        redirect_to @blog, notice: '日記を投稿しました！'
      else
        render :new
      end
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: '日記を更新しました！'
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_url, notice: '日記を削除しました！'
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:content, :picture, :picture_cache, :user_id)
  end

  def different_user
    @blog = Blog.find(params[:id])
    if current_user.id != @blog.user_id
      flash[:notice] = "他のユーザーの投稿は編集できません"
      redirect_to blogs_path
    end
  end
end

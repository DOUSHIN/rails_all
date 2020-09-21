class BlogsController < ApplicationController

  def new
    @blog = Blog.new
  end

  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    render :new if @blog.invalid?
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @blog.save
        redirect_to blogs_path, notice: "ツイートしました"
      else
        render :new
      end
    end
  end

  def index
    @blogs = Blog.all
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "編集しました"
    else
      render :edit
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "削除しました"
  end

  def show
    @blog = Blog.find(params[:id])    
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content)
  end

end

class PostsController < ApplicationController
  before_action :require_login
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Current.user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: "Post created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted successfully."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post
    redirect_to posts_path, alert: "You are not authorized to edit this post." unless @post.user == Current.user
  end

  def post_params
    params.require(:post).permit(:title, :body, tag_ids: [])
  end
end

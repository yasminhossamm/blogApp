class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]
  before_action :require_login, only: %i[create]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: "Comment was successfully created."
    else
      redirect_to @post, alert: "Comment could not be created."
    end
  end

  def edit
    @post = @comment.post
  end
  

  def update
    if @comment.update(comment_params)
      redirect_to @comment.post, notice: "Comment was successfully updated."
    else
      render :edit
    end
  end
  

  def destroy
    @comment.destroy
    redirect_to @comment.post, notice: "Comment was successfully destroyed."
  end
  

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user!
    redirect_to root_path, alert: "Not authorized" unless @comment.user == current_user
  end
  

  def require_login
    redirect_to new_session_path, alert: "You must be logged in to perform this action" unless user_signed_in?
  end
end

class CommentsController < ApplicationController
  before_action :set_comment, only: [:create, :show, :index, :approve]
  before_action :find_comment, only: [:show, :approve, :deny]

  def create
    @comment = @post.comments.create(comment_params)
    @comment.update!(user: current_user)

    redirect_to @post, notice: 'Comment was successfully created and waiting to approve.'
  end

  def show
  end

  def index
    @comments = @post.comments.all
  end

  def approve
    @comment.update!(approved: true)
    
    redirect_to dashboard_path, notice: 'Comment was successfully approved.' 
  end

  def deny
    @comment.update!(approved: false)

    redirect_to dashboard_path, notice: 'Comment was successfully denied.'
  end

  
  private

  def comment_params
    params.require(:comment).permit(:title, :content)
  end

  def set_comment
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

end

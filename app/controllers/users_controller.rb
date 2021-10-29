class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:user_id])
    @posts = @user.posts.availables.recent
    @comments = @user.comments.approved_commments?
  end

  def feed
    @posts = current_user.feed
    @users = User.all
  end
end

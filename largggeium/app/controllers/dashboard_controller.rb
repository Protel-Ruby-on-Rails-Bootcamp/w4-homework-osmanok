class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts.order(created_at: :desc)
    @comments = Comment.where("post_id IN (?)", current_user.posts.ids).non_approved?.recent
  end
end

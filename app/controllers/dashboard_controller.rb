class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts.order(created_at: :desc)
    @comments_nonapproved =
      Comment
        .where("post_id IN (?)", current_user.posts.ids)
        .non_approved?
        .recent
    @comments_approved =
      Comment
        .where("post_id IN (?)", current_user.posts.ids)
        .approved_commments?
        .recent
  end
end

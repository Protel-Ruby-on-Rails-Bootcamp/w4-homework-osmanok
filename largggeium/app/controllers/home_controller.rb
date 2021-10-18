class HomeController < ApplicationController
  def index
    @posts = Post.availables
  end
end

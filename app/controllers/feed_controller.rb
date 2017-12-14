class FeedController < ApplicationController
  def index
    redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"]
    @user = User.find_by_id(id)
    puts @user.attributes
  end
end

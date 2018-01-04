class FeedController < ApplicationController
  def index
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"]
    @user = User.find_by_id(id)
    @all_posts = []
    puts User.friends(@user[:id])
  end
end

class FeedController < ApplicationController
  def index
    if not cookies.signed[:user] then
      return redirect_to root_path
    end
    id = JSON.parse(cookies.signed[:user])["id"]
    @user = User.find_by_id(id)
    puts @user.attributes
  end
end

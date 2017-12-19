class FeedController < ApplicationController
  def index
    # cookies.delete :user
    if not cookies.signed[:user] then
      return redirect_to root_path
    end
    id = JSON.parse(cookies.signed[:user])["id"]
    @user = User.find_by_id(id)
    @user.requests_from.each { |post|
      puts post.attributes
    }
  end
end

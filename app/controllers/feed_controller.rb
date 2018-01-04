class FeedController < ApplicationController
  def index
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"]
    @user = User.find_by_id(id)
    @all_posts = []
    @all_posts.concat(@user.posts)
    my_friends = User.friends(@user[:id])
    my_friends.each { |friend|
      @all_posts.concat(friend.posts)
    }
    @all_posts.sort! {|pa, pb|
      pa[:created_at] <=> pb[:created_at]
    }
    @all_posts.reverse!
  end
end

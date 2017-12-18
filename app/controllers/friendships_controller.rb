class FriendshipsController < ApplicationController
  def create
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"].to_i
    new_friend = params[:id].to_i
    if id < new_friend then
      lower = id
      higher = new_friend
    else
      lower = new_friend
      higher = id
    end
    @new_friendship = Friendship.new(:friend_1 => lower, :friend_2 => higher)
    if @new_friendship.save then
      redirect_to root_path
    end
  end
end

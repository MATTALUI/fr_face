class FriendshipsController < ApplicationController
  def create
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"].to_i
    friend_request = Request.where({:sender_id => params[:id].to_i, :receiver_id => id}).first
    friend_request.destroy
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
      redirect_back fallback_location: root_path
    end
  end

  def delete
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"].to_i
    friend_id = params[:id].to_i

    if id < friend_id then
      lower = id
      higher = friend_id
    else
      lower = friend_id
      higher = id
    end

    friendship = Friendship.where({:friend_1 => lower, :friend_2 => higher}).first
    redirect_back fallback_location: root_path if friendship.destroy
  end
end

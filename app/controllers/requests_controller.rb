class RequestsController < ApplicationController
  def create_friendship
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"]
    # @user = User.find(id)
    puts "create friend request! from #{id} to #{params[:id]}"
    @new_friend_request = Request.new(:sender_id => id, :receiver_id => params[:id], :request_type=>:friend)
    if @new_friend_request.save then
      redirect_back fallback_location: root_path
    end
  end
end

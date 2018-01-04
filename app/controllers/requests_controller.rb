class RequestsController < ApplicationController
  def create_friendship
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"]
    @new_friend_request = Request.new(:sender_id => id, :receiver_id => params[:id], :request_type=>:friend)
    if @new_friend_request.save then
      redirect_back fallback_location: root_path
    end
  end

  def delete_friendship
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"]
    requester_id = params[:id].to_i
    relevant_request = Request.where({:sender_id => requester_id, :receiver_id => id, :request_type => :friend}).first
    redirect_back fallback_location: root_path if relevant_request.destroy
  end
end

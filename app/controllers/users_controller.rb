require 'bcrypt'
class UsersController < ApplicationController
  def new

  end

  def create
    user = params[:user]
    password = user[:password]
    confirmed = user[:confirm_password]
    if password === confirmed then
      user.delete(:confirm_password)
      hashword = BCrypt::Password.create(user[:password])
      user[:password] = hashword
      @user = User.new(user_params)
      if @user.save then
        token = JSON.generate({
          :id => @user[:id],
          :username => @user[:username],
          :email => @user[:email],
          :avatar => @user[:user_image]
        })
        cookies.signed[:user] = token
        redirect_to '/feed'
      else
        redirect_to '/'
      end


    end
  end

  def show
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"]
    @user = User.find_by_id(id)
    @relevant_user = User.find_by_id(params[:id])
    @friends = User.friends(@relevant_user[:id])
    @are_friends = (@friends.index{|friend| friend[:id] == @user[:id]} != nil)
    if not @are_friends then
      request_sent = Request.where({:sender_id => @user[:id], :receiver_id => @relevant_user[:id]}).first
      @requests_pending = (request_sent != nil)
      if not @requests_pending then
        @has_friend_request_from = false
        friend_requests = @user.requests_received.reject {|request| request[:request_type] != "friend"}
        friend_requests.each { |request|
          @has_friend_request_from = true if request[:sender_id] == @relevant_user[:id]
        }
      end
    end
  end

  def edit
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"]
    return redirect_to edit_user_path(:id=>id) if id.to_i != params[:id].to_i
    @user = User.find_by_id(id)
  end

  def update
    id = JSON.parse(cookies.signed[:user])["id"]
    @user = User.find_by_id(id)
    @user.update(user_params)
    redirect_back fallback_location: edit_user_path(@user)
  end

  def password
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"]
    @user = User.find_by_id(id)
  end

  def change_password
    return redirect_to root_path if not cookies.signed[:user]
    id = JSON.parse(cookies.signed[:user])["id"]
    @user = User.find_by_id(id)
    submitted_password = params[:passwords][:password]
    new_password = params[:passwords][:new_password]
    confirm_password = params[:passwords][:confirm_password]
    match = (BCrypt::Password.new(@user[:password]) == submitted_password)
    confirmed = new_password == confirm_password
    allswell = (match and confirmed)
    if allswell then
      hashword = BCrypt::Password.create(new_password)
      if @user.update(:password=>hashword) then
        redirect_to root_path
      end
    end
  end

  def login
    redirect_to feed_path if cookies.signed[:user]
  end

  def actually_login
    submitted_email = params[:login][:email]
    submitted_password = params[:login][:password]
    @user = User.find_by_email(submitted_email)
    if @user then
      match = (BCrypt::Password.new(@user[:password]) == submitted_password)
      if match then

      token = JSON.generate({
        :id => @user[:id],
        :username => @user[:username],
        :email => @user[:email],
        :avatar => @user[:user_image]
      })
      cookies.signed[:user] = token
      redirect_to feed_path
      end
    else
      redirect_to login_path
    end
  end

  def logout
    cookies.delete :user
    redirect_to root_path
  end

  private
    def user_params
      return params.require(:user).permit(:first_name, :last_name, :email, :password, :username, :description, :user_image, :gender)
    end
end

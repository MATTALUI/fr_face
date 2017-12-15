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
      @user = User.new(new_user_params)
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
    puts 'user'
    puts cookies.signed[:user]["id"]
    id = JSON.parse(cookies.signed[:user])["id"]
    @user = User.find_by_id(id)
    @relevant_user = User.find_by_id(params[:id])
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
    def new_user_params
      return params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end

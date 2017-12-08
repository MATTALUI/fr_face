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
        puts @user
        cookies.signed[:user] = @user[:id].to_s
        redirect_to '/feed'
      else
        redirect_to '/'
      end


    end
  end
  def login
    
  end


  private
    def new_user_params
      return params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end

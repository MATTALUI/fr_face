class UsersController < ApplicationController
  def new
    puts 'Someone is signing up! Yay!'
  end

  def create
    puts params[:user].inspect
    # redirect_to
  end
end

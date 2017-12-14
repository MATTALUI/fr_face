class FeedController < ApplicationController
  def index
    redirect_to root_path if not cookies.signed[:user]
    puts
    puts
    puts 'index!'
    puts cookies.signed[:user]
    puts
    puts
  end
end

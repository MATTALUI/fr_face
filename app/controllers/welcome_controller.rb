class WelcomeController < ApplicationController
  def index
    redirect_to '/feed' if cookies.signed[:user]
  end
end

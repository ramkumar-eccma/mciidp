class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def minor
  end
end

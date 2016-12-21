class HomeController < ApplicationController
  def index
    if current_user
      redirect_to users_url
    end
  end
end

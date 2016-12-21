class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    if session[:user_id] == nil
      redirect_to root_url
    end
  end

  helper_method :current_user
  helper_method :require_login
end

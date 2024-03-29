class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private 
  def current_user
  	@current_user ||= Users.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
  	unless current_user
  		redirect_to root_url
  	end
  end

  def save_login_state!
  	if session[:user_id]
  		redirect_to "/home"
  		return false
  	else
  		return true
  	end
  end
end

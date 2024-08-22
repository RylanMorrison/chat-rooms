class ApplicationController < ActionController::Base
  protect_from_forgery

protected

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end
  helper_method :current_user

  def authorize_user
    redirect_to login_url, alert: 'Not authorised' if current_user.blank?
  end
end

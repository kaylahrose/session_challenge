class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by_id!(session[:user_id]) if session[:user_id]
  end

  def admin_user
    current_user && @current_user.admin?
      # @admin_user ||= User.find_by_id!(session[:user_id]) && user.admin?
    # end?
  end
  helper_method :current_user, :admin_user
end

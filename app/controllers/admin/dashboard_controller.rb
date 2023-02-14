class Admin::DashboardController < ApplicationController
  def index
    if admin_user
      @user = User.find(session[:user_id])
      @default_users = User.default_users
    else
      flash[:error] = "You are not authorized to access this page"
      redirect_to root_path
    end
  end
end 
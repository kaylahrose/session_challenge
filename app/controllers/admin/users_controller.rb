class Admin::UsersController < ApplicationController
  def show
    if admin_user
      @user = User.find(params[:id])
      render "users/show"
    else
      flash[:error] = "You are not authorized to access this page"
      redirect_to root_path
    end
  end
end
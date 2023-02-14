class MoviesController < ApplicationController
  def index
    if current_user
      @user = User.find(session[:user_id])
      @movies = Movie.all
    else
      flash[:error] = 'You must be logged in or registered to access your dashboard'
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:user_id])
    @movie = Movie.find(params[:id])
  end
end

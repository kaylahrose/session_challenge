class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    if current_user
        @user = User.find(session[:user_id])
    else
      flash[:error] = "You must be logged in or registered to access your dashboard"
      redirect_to root_path
    end
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/dashboard'
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  def login_form; end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to admin_dashboard_path
      else user.default?
        redirect_to dashboard_path
      end
    else
      flash[:error] = 'Bad Credentials, try again.'
      redirect_to '/login'
    end
  end

  def logout_user
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end

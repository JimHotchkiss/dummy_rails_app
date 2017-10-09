class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:username])

    if logged_in?
      redirect_to '/'

    elsif params[:username].nil? || params[:username] == ""
      flash[:notice] = "Please complete login form"
      redirect_to session_login_path

    elsif @user.nil?
      flash[:notice] = "You need to signup"
      redirect_to '/'

    else
      return redirect_to '/' unless @user.authenticate(params[:password])
      user_id = @user.id
      session[:user_id] = user_id
      redirect_to '/'
    end
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end
end

class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:username])

    if logged_in?
      redirect_to root_path

    elsif params[:username].nil? || params[:username] == ""
      flash[:notice] = "Please complete login form"
      redirect_to session_login_path

    elsif @user.nil?
      flash[:notice] = "You need to signup"
      redirect_to root_path

    else
      return redirect_to root_path unless @user.authenticate(params[:password])
      user_id = @user.id
      session[:user_id] = user_id
      redirect_to root_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end
end

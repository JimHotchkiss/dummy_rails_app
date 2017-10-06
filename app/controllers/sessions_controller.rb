class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if !session[:username].nil? # if you're already logged in redirect_to root
      redirect_to '/'
    else
      if params[:username].nil? || params[:username] == ""
        redirect_to login_path
      else
        username = params[:username]
        session[:username] = username
        redirect_to '/'
      end
    end
  end

  def destroy
    session.delete :username
    redirect_to '/'
  end
end

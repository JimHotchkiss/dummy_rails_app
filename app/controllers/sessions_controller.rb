class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if !session[:user_id].nil? # if you're already logged in redirect_to root
      redirect_to '/'
    else
      # However, I have no password authentication in here
      if params[:username].nil? || params[:username] == ""
        redirect_to login_path
      else
        user_id = params[:id]
        session[:user_id] = user_id
        redirect_to '/'
      end
    end
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end
end

class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:username])

    if logged_in? # if you're already logged in redirect_to root
      redirect_to '/'
    end
      # However, I have no password authentication in here
      if params[:username].nil? || params[:username] == ""
        render :new
      else
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

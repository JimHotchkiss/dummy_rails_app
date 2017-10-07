class SessionsController < ApplicationController

  def new
  end

  def create
    if session[:username].present? # if you're already logged in redirect_to root
      redirect_to '/'
    end
      # However, I have no password authentication in here
      if params[:username].nil? || params[:username] == ""
        render :new
      else
        username = params[:username]
        session[:username] = username
        redirect_to '/'
      end
  end

  def destroy
    session.delete :username
    redirect_to '/'
  end
end

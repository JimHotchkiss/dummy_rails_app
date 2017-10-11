class SessionsController < ApplicationController

  def new
  end

  def create
    # if auth_hash is true, we know user is signing in using Oauth
    if auth_hash = request.env['omniauth.auth']
      oauth_username = request.env['omniauth.auth']['info']['name']
    # if we find them, using username, in the db, log them in
      if user = User.find_by(username: oauth_username)
        session[:user_id] = user.id
        redirect_to root_path, notice: ', you are signed in'
      else
    # if we can't find them, instantiate a user, and give them a random password
        user = User.new(username: oauth_username, password: SecureRandom.hex)

        if user.save
          session[:user_id] = user.id
          redirect_to root_path, notice: 'you have signed up'
        end
      end

    else
    # else we are gong to use our normal authentication login
      @user = User.find_by(username: params[:username])
      if logged_in?
        redirect_to root_path
      elsif params[:username].nil? || params[:username] == ""
        redirect_to session_login_path, notice: "Please complete login form"
      elsif @user.nil?
        redirect_to root_path, notice: "you need to signup" 
      else
        return redirect_to root_path unless @user.authenticate(params[:password])
        user_id = @user.id
        session[:user_id] = user_id
        redirect_to root_path, notice: ', you are signed in'
      end
    end

  end


  def destroy
    session.delete :user_id
    redirect_to root_path, notice: 'signed out'
  end

end

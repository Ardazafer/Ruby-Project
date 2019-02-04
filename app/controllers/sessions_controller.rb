class SessionsController < ApplicationController
  def new
    
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]

    user = User.find_by_email(email)

    if user && user.authenticate(password)
      log_in user
      params[:session][:remember_me]  == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] ='Invalid email/password combination'
      render 'new'
    end


  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

end

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      login(user)
      redirect_to user
    else
      flash.now[:error] = 'Bad email/password combination. Please try again.'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to site_home_path
  end
end

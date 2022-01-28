class SessionsController < ApplicationController

  def create
    user = User.find_by(email: login_params[:email].downcase)
    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      redirect_to request.referer || root_path, :notice => "Welcome back, #{user.fullname}!"
    else
      redirect_to request.referer || root_path, :alert => "Sorry, your email or password is incorrect."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to request.referer || root_path, :notice => "You have successfully logged out."
  end

  private 

  def set_article
    @user = User.find(params[:id])
  end

  def login_params
    params.require(:session).permit(:email, :password)
  end
  

end
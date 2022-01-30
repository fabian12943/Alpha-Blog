class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 12)
  end

  def show
    @articles = @user.articles.order(created_at: :desc).paginate(page: params[:page], per_page: 4)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Welcome to the Alpha Blog, #{@user.fullname}! You have successfully signed up."
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Your account informations were successfully updated."
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to articles_path, notice: "Your profile and all of your articles were successfully deleted."
  end

  private 

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
  end

  def require_same_user
    if current_user != @user
      redirect_to @user, alert: "You are not authorized to edit this user's profile."
    end
  end
  
end
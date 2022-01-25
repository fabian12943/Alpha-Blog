class UsersController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update]

  def index
    @users = User.paginate(page: params[:page], per_page: 12)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 4)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
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

  private 

  def set_article
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
  end
  
end
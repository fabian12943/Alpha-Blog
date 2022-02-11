class PasswordResetsController < ApplicationController

  def create
    @user = User.find_by(email: params[:email].downcase)
    
    if @user.present?
      PasswordMailer.reset(@user).deliver_later
    end

    redirect_to root_url, notice: "If an user with this email address exists, you will receive an email with instructions on how to reset your password shortly."
  end

  def edit
    @user = User.find_signed(params[:token], purpose: "password_reset")
    redirect_to root_url, alert: "Invalid or expired token." if @user.nil?
  end

  def update
    @user = User.find_signed(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      redirect_to root_url, notice: "Your password has been updated successfully."
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password)
  end
  
end

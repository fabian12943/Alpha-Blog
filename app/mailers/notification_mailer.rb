class NotificationMailer < ApplicationMailer

  def user_signup_notification(user)
    @user = user
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/assets/images/logo.png")
    mail( to: @user.email,
          subject: 'Welcome to the Alpha-Blog!' )
  end
  
end

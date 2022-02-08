# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview

  def signup
    user = User.first
    NotificationMailer.user_signup_notification(user)
  end
  
end

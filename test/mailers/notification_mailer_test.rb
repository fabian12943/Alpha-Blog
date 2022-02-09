require "test_helper"

class NotificationMailerTest < ActionMailer::TestCase

  def setup
    @user = users(:user_1)
  end

  test 'signup' do
    email = NotificationMailer.user_signup_notification(@user)
    assert_emails 1 do
      email.deliver_later
    end

    assert_equal email.to, [@user.email]
    assert_equal email.from, [Rails.application.credentials.sendgrid[:email]]
    assert_equal email.subject, 'Welcome to the Alpha-Blog!'
    assert_not_nil email.attachments['logo.png'], "No logo.png attached to email"
    assert_match 'Welcome to the Alpha Blog, ' + @user.first_name, email.body.encoded
  end

end

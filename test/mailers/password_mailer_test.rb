require "test_helper"

class PasswordMailerTest < ActionMailer::TestCase

  def setup
    @user = users(:user_1)
  end

  test "reset" do
    mail = PasswordMailer.reset(@user)
    assert_emails 1 do
      mail.deliver_later
    end

    assert_equal "Reset your password", mail.subject
    assert_equal [@user.email], mail.to
    assert_equal [Rails.application.credentials.sendgrid[:email]], mail.from
  end

end

class PasswordMailer < ApplicationMailer

  def reset(user)
    @user = user
    @token = user.signed_id(expires_in: 1.hour, purpose: "password_reset")
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/assets/images/logo.png")
    mail( to: @user.email,
          subject: 'Reset your password' )
  end

end

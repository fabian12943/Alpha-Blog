class ApplicationMailer < ActionMailer::Base
  default from: "Alpha-Blog <#{Rails.application.credentials.sendgrid[:email]}>"
  layout 'mailer'
end

class UserMailer < ActionMailer::Base
  default from: "info@gowensindustries.com"

  def welcome_email(user)
    @user=user
    @url = 'http://www.gowensindustries.com:3000/signin'
    mail(to: @user.email, subject: "This is the test email!")
  end
end

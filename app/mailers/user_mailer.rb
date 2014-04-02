class UserMailer < ActionMailer::Base
  default from: "Timezone@gowensindustries.com"

  def welcome_email(user)
    @user=user
    @url = 'http://www.gowensindustries.com:3000/signin'
    mail(to: @user.email, subject: "Welcome!")
  end

  def reminder_email(user, reminder)
    @user=user
    @reminder=reminder
    mail(to: @user.email, subject: "Reminder!")
  end
end

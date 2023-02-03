class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_email.subject
  #
  # def send_email(email, name)
  def welcome(email, name)
    # @greeting = "Hi"

    # mail to: "to@example.org", subject: 'News'

    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end



end

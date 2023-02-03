class PostMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.send_mail.subject
  #
  def send_mail
    @greeting = "Hi"

    mail(
      to: "filipejvmf@gmail.com",
      cc:"elainediaspires16@gmail.com",
      subject: "Newsletter"
    )
    # mail to: User.first.email
  end
end

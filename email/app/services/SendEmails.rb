class SendEmails
  def self.send
    users = User.all

    users.each do |user|
      PostMailer.with(user: user).send_mail.deliver_now
    end
  end
end

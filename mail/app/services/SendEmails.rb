class SendEmails
  def self.send
    users = User.all

    users.each do |user|
      UserMailer.send_email(user.email, user.name).deliver_now
    end
  end
end

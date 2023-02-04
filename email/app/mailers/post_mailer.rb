class PostMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.send_mail.subject

  
  def send_mail
    category = 'technology'
    country = 'br'
    q = nil
    pageSize = 5
    apiKey = '76bf58dcc49148318f4ad8c4ea63549d'
    api = News.new(apiKey)
    @news = api.get_top_headlines(category: category, country: country, q: q, pageSize: pageSize)


    @user = params[:user]
    @day = DateTime.now.day.to_s.rjust(2, '0')
    @month = DateTime.now.month.to_s.rjust(2, '0')
    @year = DateTime.now.year

    mail(
      to: @user.email,
      subject: "Terubytes Newsletter #{@day}/#{@month}/#{@year}"
    )
  end
end

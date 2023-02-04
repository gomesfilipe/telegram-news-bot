require 'telegram/bot'
require 'date'
require_relative '../news-api/newsApi.rb'

class NewsBot
  def initialize(token, channel, hour, min, category, country, q, pageSize)
    @token = token
    @channel = channel
    @hour = hour
    @min = min
    @category = category
    @country = country
    @q = q
    @pageSize = pageSize
  end

  private def send_news(bot)
    news = NEWS_API.get_news(@category, @country, @q, @pageSize)  
    messages = self.format_message(news)
    
    messages.each do |message|
      bot.api.send_message(chat_id: @channel, text: message)
    end
  end
  
  def run()
    Telegram::Bot::Client.run(@token) do |bot|
      puts 'Running NewsBot!'
      loop do
        if(DateTime.now.hour == @hour and DateTime.now.min == @min)
          self.send_news(bot)
        end

        sleep(60)
      end
    end   
    
    # Telegram::Bot::Client.run(@token) do |bot|
    #   puts 'Running NewsBot!'
    #   loop do
    #     if(DateTime.now.hour == @hour)
    #       self.send_news(bot)
    #     end

    #     sleep(3600)
    #   end
    # end  
  end
  
  private def format_message(news)
    messages = []
    messages.push("Notícias do dia #{DateTime.now.day.to_s.rjust(2, '0')}/#{DateTime.now.month.to_s.rjust(2, '0')}/#{DateTime.now.year}")

    news.each do |item|
      message = "#{item.title}\n\n"
      message += "#{item.url}"
      messages.push(message)
    end

    return messages
  end
end

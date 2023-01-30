require 'telegram/bot'
require 'date'
require_relative '../news-api/newsApi.rb'

class TelegramBot
  def initialize(token, channel, hour, category, country, q, pageSize)
    @token = token
    @channel = channel
    @hour = hour
    @category = category
    @country = country
    @q = q
    @pageSize = pageSize
  end

  def send_news(bot)
    news = NEWS_API.get_news(@category, @country, @q, @pageSize)  
    messages = self.format_message(news)
    
    messages.each do |message|
      bot.api.send_message(chat_id: @channel, text: message)
    end
  end
  
  def run_Bot()
    Telegram::Bot::Client.run(@token) do |bot|
      puts 'Running bot!'
      loop do
        if(DateTime.now.hour == @hour)
          self.send_news(bot)
        end

        sleep(3600)
      end
    end    
  end
  
  def format_message(news)
    messages = []
    messages.push("Notícias do dia #{DateTime.now.day}/#{DateTime.now.month}/#{DateTime.now.year}")

    news.each do |item|
      message = "#{item.title}\n\n"
      message += "#{item.url}"
      messages.push(message)
    end

    return messages
  end
end

# 5957158525:AAGzLeCzfSD2Zk7aD_wguHhSxPM2GJMpx6I
# require 'telegram/bot'
# require './api' nao precisa
# require 'date'

# token = ENV['token']
# channel_id = -1001611469235 # Canal
# hour_to_send_message = 14
# # channel_id = -1001891274741: # Chat

# category = 'technology'
# country = 'br'
# q = 'software'
# pageSize = 5

# time = 3600

# Telegram::Bot::Client.run(token) do |bot|
#   p 'Running bot!'
  
#   loop do
#     if(DateTime.now.hour == hour_to_send_message)
#       news = get_news(category, country, q, pageSize)
#       title = "**Notícias do dia #{DateTime.now.day}/#{DateTime.now.month}/#{DateTime.now.year}**"
#       bot.api.send_message(chat_id: channel_id, text: title)
      
#       news.each do |item|
#         text = item.title + "\n\n"
#         text += item.url
#         bot.api.send_message(chat_id: channel_id, text: text)
#       end
#     end
      
#     sleep(time)
#   end
#   # try catch
#   # bot.listen do |message|
#   #   puts message.chat.id
#   #   puts message.chat.id.class
#   #   puts message.text
#   # end
# end

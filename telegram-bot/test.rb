require_relative './telegramBot.rb'
require_relative './env.rb'

token = ENV['token']
channel = ENV['channel']
hour = 14
category = 'technology'
country = 'br'
q = nil
pageSize = 1

bot = TelegramBot.new(token, channel, hour, category, country, q, pageSize)

bot.run_Bot()

# puts bot.token
# puts bot.channel
# puts NEWS_API::API_KEY

# news = bot.send_news(nil)

# puts bot.format_message(news)
require_relative './telegramBot.rb'

bot = TelegramBot.new('token1', 'channel1')

puts bot.token
puts bot.channel
puts NEWS_API::API_KEY
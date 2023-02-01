require_relative './NewsBot.rb'
require_relative './env.rb'

token = ENV['token']
channel = ENV['channel']
hour = 10
category = 'technology'
country = 'br'
q = nil
pageSize = 1

bot = NewsBot.new(token, channel, hour, category, country, q, pageSize)
bot.run()

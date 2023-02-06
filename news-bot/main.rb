require_relative './NewsBot.rb'
require_relative './env.rb'

token = ENV['token']
channel = ENV['channel']
hour = 19
min = 35
category = 'technology'
country = 'br'
q = nil
pageSize = 5

bot = NewsBot.new(token, channel, hour, min, category, country, q, pageSize)
bot.run()

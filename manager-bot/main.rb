require_relative './ManagerBot.rb'
require_relative './env.rb'

token = ENV['token']
invite = ENV['invite']

bot = ManagerBot.new(token, invite)
bot.run()

require 'telegram/bot'
require_relative '../news-api/newsApi.rb'

class TelegramBot
  def initialize(token, channel)
    @token = token
    @channel = channel
  end

  def token
    @token
  end

  def channel
    @channel
  end
end

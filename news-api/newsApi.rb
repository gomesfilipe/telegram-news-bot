require 'news-api'
require './env'

module NEWS_API
  API_KEY = ENV['API_KEY']
  
  def get_news(category, country, q, pageSize)
    apiKey = API_KEY
    api = News.new(apiKey)
    api.get_top_headlines(category: category, country: country, q: q, pageSize: pageSize)
  end  
end

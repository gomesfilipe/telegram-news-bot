require_relative './newsApi.rb'

category = 'technology'
country = 'br'
q = 'software'
pageSize = 5

news = NEWS_API.get_news(category, country, nil, pageSize)

news.each do |item|
  puts item.title 
end
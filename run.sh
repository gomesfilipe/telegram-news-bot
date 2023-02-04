# Para rodar o manager-bot
cd manager-bot
ruby main.rb &
export PID_MANAGER_BOT=$!

# Para rodar o news-bot
cd ..
cd news-bot
ruby main.rb &
export PID_NEWS_BOT=$!

# Para rodar o backend de email
cd ..
cd email 
rails s  &
export PID_EMAIL_BACKEND=$!

# Voltando ao diretório raiz
cd ..

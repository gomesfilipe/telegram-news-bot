cd email
sudo service cron start
bundle exec whenever --clear-crontab
bundle exec whenever --update-crontab --set environment='development'
cd ..

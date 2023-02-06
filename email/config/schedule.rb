# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :environment, "development"
# env :PATH, ENV['PATH']
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every 1.day, at: '19:35' do
  runner "SendEmails.send", :environment => "development"
end

# bundle exec whenever --update-crontab --set environment='development' 
# bundle exec whenever --clear-crontab

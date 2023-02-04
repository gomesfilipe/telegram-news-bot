# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :environment, "development"
# env :PATH, ENV['PATH']
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}
# set :output, "../log/cron_log.log"

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
every 1.minute do
  # runner "SendEmails.send", :environment => "development"
  command "echo 'hello world!' " #, :environment => "development"
  # command "/usr/bin/some_great_command"
  # rake "some:great:rake:task"
end
#

# every 1.day, at: '9:00' do
#   runner "SendEmails.send", :environment => "development"
# end

# bundle exec whenever --update-crontab --set environment='development' 
# bundle exec whenever --clear-crontab
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


# every 1.day, :at => "12:01am" do
#   runner "Task.generate_tasks_for_day"  
# end

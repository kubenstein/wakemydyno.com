desc "This task is called by the Heroku scheduler add-on"
task :pinging => :environment do
  Url.pinging_in_rake_task
end

task :url_check => :environment do
  Url.url_check_in_rake_task
end

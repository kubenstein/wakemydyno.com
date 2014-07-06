desc "This task is called by the Heroku scheduler add-on"
task :pinging => :environment do
  PingService.new.perform
end

task :url_check => :environment do
  UrlCheckService.new.perform
end

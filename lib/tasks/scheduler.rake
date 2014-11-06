desc "This task is called by the Heroku scheduler add-on"
task :pinging => :environment do
  BackgroundProcessesService.start_ping_process
end

task :url_check => :environment do
  BackgroundProcessesService.start_url_check_process
end

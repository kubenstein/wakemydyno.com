desc "This task is called by the Heroku scheduler add-on"
task :pinging => :environment do
  BackgroundProcessesService.start_pinging_process
end

task :url_check => :environment do
  BackgroundProcessesService.start_urls_checking_process
end

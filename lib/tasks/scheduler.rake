desc "This task is called by the Heroku scheduler add-on"
task :pinging => :environment do
  BackgroundProcessSpawnerService.spawn_ping_process
end

task :url_check => :environment do
  BackgroundProcessSpawnerService.spawn_url_check_process
end

desc "This task is called by the Heroku scheduler add-on"
task :pinging => :environment do
  Url.in_rake_task
end

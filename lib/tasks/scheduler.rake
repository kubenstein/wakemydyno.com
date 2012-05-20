desc "This task is called by the Heroku scheduler add-on"
task :pinging => :environment do
  puts "Hourly pinging..."
  Url.all.each do |url|
    puts "pinging #{url.address}..."
    url.ping
  end
  puts "done."
end

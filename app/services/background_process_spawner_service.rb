class BackgroundProcessSpawnerService

  def self.spawn_ping_process
    sleep 20.seconds
    while true do
      puts "25min pinging..."
      PingService.new.perform
      puts "done."
      sleep 25.minutes
    end
  end

  def self.spawn_url_check_process
    initial_waiting_for_midnight_in_seconds = 24.hours - Time.now.seconds_since_midnight.to_i
    puts "initial waiting (#{initial_waiting_for_midnight_in_seconds}s) till next midnight... "
    sleep initial_waiting_for_midnight_in_seconds

    while true do
      puts "daily url check..."
      UrlCheckService.new.perform
      puts "done."
      sleep 24.hours
    end
  end

end

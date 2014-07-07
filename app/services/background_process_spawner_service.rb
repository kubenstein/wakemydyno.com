class BackgroundProcessSpawnerService

  def self.spawn_ping_process
    initial_waiting_for_next_half_an_hour_in_seconds = (30 - Time.now.min%30) * 1.minute
    puts "initial waiting (#{initial_waiting_for_next_half_an_hour_in_seconds}s) till next half an hour... "
    sleep initial_waiting_for_next_half_an_hour_in_seconds
    while true do
      puts "30min pinging..."
      PingService.new.perform
      puts "done."
      sleep 30.minutes
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

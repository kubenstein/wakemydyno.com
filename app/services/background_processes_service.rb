class BackgroundProcessesService

  def self.start_ping_process(initial_sleep = 20.seconds, loop_condition = -> { true }, inloop_sleep = 20.minutes)
    sleep initial_sleep
    while loop_condition.call do
      puts "25min pinging..."
      PingService.new.perform
      puts "done."
      sleep inloop_sleep
    end
  end

  def self.start_url_check_process(initial_sleep = 24.hours - Time.now.seconds_since_midnight.to_i, loop_condition = -> { true }, inloop_sleep = 24.hours)
    initial_waiting_for_midnight_in_seconds = initial_sleep
    puts "initial waiting (#{initial_waiting_for_midnight_in_seconds}s) till next midnight... "
    sleep initial_waiting_for_midnight_in_seconds

    while loop_condition.call do
      puts "daily url check..."
      UrlCheckService.new.perform
      puts "done."
      sleep inloop_sleep
    end
  end

end

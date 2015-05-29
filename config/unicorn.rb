worker_processes 4
timeout 30
preload_app true

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end

  # Dynos will go sleep now...
  # @pinging_background_process_pid ||= spawn('bundle exec rake pinging')
  # @urlcheck_background_process_pid ||= spawn('bundle exec rake url_check')

  sleep 1
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    Rails.logger.info('Connected to ActiveRecord')
  end
end
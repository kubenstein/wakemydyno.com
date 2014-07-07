class PingService

  def perform
    Url.find_each do |url|
      puts "pinging #{url.address}..."
      url.ping!
    end
  end

end

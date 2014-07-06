class PingService

  def perform
    minutes = Time.now.min
    return if !(minutes.between?(25, 34) || minutes.between?(55, 60) || minutes.between?(0, 4))

    puts "30min pinging..."
    Url.find_each do |url|
      puts "pinging #{url.address}..."
      url.ping!
    end
    puts "done."
  end

end

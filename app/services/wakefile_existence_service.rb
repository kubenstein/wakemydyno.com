class WakefileExistenceService < Struct.new(:address)

  def wake_file_founded?(timeout = 90)
    uri = URI "#{address}/wakemydyno.txt"
    request = Net::HTTP::Head.new(uri.request_uri)
    Timeout::timeout(timeout) do
      response = Net::HTTP.start(uri.host, uri.port) { |h| h.request request }
      unless response.code == '200'
        raise "wakemydyno.txt not found for #{address}"
      end
    end
    true
  rescue Exception => err
    puts "! #{err.message}"
    false
  end

end

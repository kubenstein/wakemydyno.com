class WakefileExistenceService < Struct.new(:address)

  def wake_file_founded?(timeout = 10)
    response = HTTParty.get("#{address}/wakemydyno.txt", timeout: timeout)
    unless response.code == 200
      raise "wakemydyno.txt not found for #{address}"
    end
    true

  rescue URI::InvalidURIError
    puts "! url is invalid: #{address}"
    false
  rescue Exception => err
    puts "! #{err.message}"
    Raven.capture_exception(err)
    false
  end

end

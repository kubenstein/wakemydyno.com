class WakefileExistenceService < Struct.new(:address)
  attr_accessor :error_message

  def wake_file_founded?(timeout = 10)
    response = HTTParty.get("#{address}/wakemydyno.txt", timeout: timeout)
    unless response.code == 200
      self.error_message = "We can't find wakemydyno.txt file on requested site"
      return false
    end
    true

  rescue Exception => err
    self.error_message = "We can't connect to requested site, please try again"
    Raven.capture_exception(err)
    false
  end

end

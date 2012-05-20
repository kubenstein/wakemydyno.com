class Url < ActiveRecord::Base
  attr_accessible :address
  before_validation :trim_ending_slash

  validates_format_of :address, with: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\/?$/ix
  validate :address_uniqueness
  validate :check_wakefile_existence, :on => :create

  #
  # for rake task
  def ping
    wake_file_founded?(1)
    self.pinged += 1
    save
  end

  def should_be_deleted?
    founded = wake_file_founded?
    return true if not founded and self.mark_for_deletion
    self.mark_for_deletion = !founded
    return false
  end

  private

  def trim_ending_slash
    address.chomp! '/'
  end

  def check_wakefile_existence
    if !wake_file_founded?
      self.errors[:base] << "We can't find wakemydyno.txt file on requested site"
      false
    end
  end

  def address_uniqueness
    if Url.where(address: self.address).count != 0
      self.errors[:base] << "This url is already in our dyno database"
      false
    end
  end

  def wake_file_founded?(timeout = 60)
    begin
      uri = URI "#{address}/wakemydyno.txt"
      request = Net::HTTP::Head.new(uri.request_uri)
      Timeout::timeout(timeout) do
        response = Net::HTTP.start(uri.host, uri.port) { |h| h.request request }
        if response.code != "200"
          raise "not found"
        end
      end
      true
    rescue Exception => err
      puts err.message
      false
    end
  end
end

class Url < ActiveRecord::Base
  attr_accessible :address
  before_validation :trim_ending_slash

  validates_format_of :address, with: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\/?$/ix
  validate :address_uniqueness
  validate :check_wakefile_existence, :on => :create

  #
  # for rake task
  def ping
    connect(1)
    self.pinged += 1
    save
  end


  private

  def trim_ending_slash
    address.chomp! '/'
  end

  def check_wakefile_existence
    if connect.code != "200"
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

  def connect(timeout = 60)
    uri = URI "#{address}/wakemydyno.txt"
    request = Net::HTTP::Head.new(uri.request_uri)
    begin
      Timeout::timeout(timeout) do
        Net::HTTP.start(uri.host, uri.port) { |h| h.request request }
      end
    rescue Exception => err
      puts err.message
    end
  end
end

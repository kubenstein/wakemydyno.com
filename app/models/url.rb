class Url < ActiveRecord::Base
  attr_accessible :address
  before_validation :trim_ending_slash

  validates_format_of :address, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\/?$/ix
  validates_uniqueness_of :address
  validate :wakefile_on_remote_server, :on => :create



  private

  def trim_ending_slash
    address.chomp! '/'
  end

  def wakefile_on_remote_server
    if Net::HTTP.get_response(URI.parse("#{address}/wakemydyno.txt")).code.to_i != "200"
      self.errors[:base] << "We can't find wakemydyno.txt file on requested site"
      false
    end
  end

end

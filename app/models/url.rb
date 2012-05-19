class Url < ActiveRecord::Base
  attr_accessible :address
  before_save :trim_ending_slash

  validates_format_of :address, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\/?$/ix


  private

  def trim_ending_slash
    address.chomp! '/'
  end
end

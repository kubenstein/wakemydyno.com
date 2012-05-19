class Ping < ActiveRecord::Base
  attr_accessible :url
  before_save :trim_ending_slash

  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\/?$/ix


  private

  def trim_ending_slash
    url.chomp! '/'
  end
end

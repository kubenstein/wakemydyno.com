# == Schema Information
#
# Table name: urls
#
#  id                  :integer          not null, primary key
#  address             :string(255)
#  marked_for_deletion :boolean          default(FALSE)
#  pinged              :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Url < ActiveRecord::Base
  attr_accessible :address, :marked_for_deletion
  before_validation :trim_ending_slash

  validates :address,
            presence: true,
            uniqueness: {
                message: 'This url is already in our dyno database'
            },
            format: {
                with: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\/?$/ix,
                message: 'Url format is invalid'
            }
  validate :check_wakefile_existence, on: :create


  def ping!
    WakefileExistenceService.new(address).wake_file_founded?(1)
    self.increment!(:pinged)
  end

  def check!
    page_is_still_valid = WakefileExistenceService.new(address).wake_file_founded?(10)
    self.update_attributes!(marked_for_deletion: !page_is_still_valid)
  end

  private

  def trim_ending_slash
    address.chomp! '/'
  end

  def check_wakefile_existence
    unless WakefileExistenceService.new(address).wake_file_founded?
      self.errors[:base] << "We can't find wakemydyno.txt file on requested site"
      false
    end
  end

end

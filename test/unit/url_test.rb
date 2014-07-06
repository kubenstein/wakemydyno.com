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

require 'test_helper'

class UrlTest < ActiveSupport::TestCase

  test "address uniqueness" do
    valid = FactoryGirl.build(:url)
    invalid = FactoryGirl.build(:url)

    assert_difference('Url.count') do
      valid.save
      invalid.save
    end

    assert_equal "This url is already in our dyno database", invalid.errors.full_messages.first
  end

  test "address ending slash trimming" do
    assert_not_equal '/', FactoryGirl.create(:url, address: 'http://test.com/').address[-1]
  end

  test "pinging" do
    url = FactoryGirl.create(:url)
    url.ping!
    assert_equal 1, url.pinged
  end

  test "check!" do
    url = FactoryGirl.create(:url)
    url.address = 'http://nofile.com' #mock
    url.save

    assert_equal false, url.marked_for_deletion?
    url.check!
    assert_equal true, url.marked_for_deletion?
  end

end

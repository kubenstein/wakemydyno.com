require 'test_helper'

class PingServiceTest < ActiveSupport::TestCase

  test "half-hourly pining" do
    url1 = FactoryGirl.create(:url, pinged: 10)
    url2 = FactoryGirl.create(:url, address: 'http://test2.com')

    PingService.new.perform
    assert_equal url1.reload.pinged, 11
    assert_equal url2.reload.pinged, 1
  end

end

require 'test_helper'

class PingServiceTest < ActiveSupport::TestCase

  test "half-hourly pining" do
    t = Time.local(2012, 5, 24, 21, 0)
    Timecop.travel(t)
    url = FactoryGirl.create(:url)
    pings = url.pinged

    # since heroku scheduler runs in 10 min cycles, there will be 6 runs in hour
    [:ping, :not_ping, :not_ping, :ping, :not_ping, :not_ping].each do |action|
      PingService.new.perform
      pings += 1 if action == :ping
      assert_equal pings, Url.first.pinged
      Timecop.freeze(10*60)
    end

    Timecop.return
  end

end

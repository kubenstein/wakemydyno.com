require 'test_helper'

class UrlTest < ActiveSupport::TestCase

  test "address uniqueness" do
    valid = FactoryGirl.build(:url)
    invalid = FactoryGirl.build(:url)

    assert_difference('Url.count', 1) do
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

  test "should be deleted" do
    url = FactoryGirl.create(:url)
    url.address = 'http://nofile.com' #mock
    url.save

    assert_equal false, url.should_be_deleted?
    assert_equal true, url.should_be_deleted?
  end

  test "daily deletion" do
    url = FactoryGirl.create(:url)
    url.address = 'http://nofile.com' #mock
    url.mark_for_deletion = true
    url.save

    assert_difference('Url.count', -1) do
      Url.url_check_in_rake_task
    end
  end

  test "half-hourly pining" do
    t = Time.local(2012, 5, 24, 21, 0)
    Timecop.travel(t)
    url = FactoryGirl.create(:url)
    pings = url.pinged

    # since heroku scheduler runs in 10 min cycles, there will be 6 runs in hour
    [:ping, :not_ping, :not_ping, :ping, :not_ping, :not_ping].each do |action|
      Url.pinging_in_rake_task
      pings += 1 if action == :ping
      assert_equal pings, Url.first.pinged
      Timecop.freeze(10*60)
    end

    Timecop.return
  end
end

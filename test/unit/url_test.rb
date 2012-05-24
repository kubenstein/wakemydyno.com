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
end

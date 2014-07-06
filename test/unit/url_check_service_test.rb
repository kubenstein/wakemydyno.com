require 'test_helper'

class UrlCheckServiceTest < ActiveSupport::TestCase

  test "daily deletion" do
    url = FactoryGirl.create(:url)
    url.address = 'http://nofile.com' #mock
    url.marked_for_deletion = true
    url.save

    assert_difference('Url.count', -1) do
      UrlCheckService.new.perform
    end
  end

end

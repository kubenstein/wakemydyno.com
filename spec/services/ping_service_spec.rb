require 'spec_helper'

describe PingService do

  it 'should ping all urls' do
    ping_calls_count = 0
    Url.any_instance.stub(:ping!) { ping_calls_count += 1 }

    FactoryGirl.create(:url)
    FactoryGirl.create(:url, address: 'http://test2.com')
    PingService.new.perform
    expect(ping_calls_count).to eq 2
  end

end

require 'spec_helper'

describe UrlCheckService do

  it 'should check all urls' do
    check_calls_count = 0
    Url.any_instance.stub(:check!) { check_calls_count += 1 }

    FactoryGirl.create(:url)
    FactoryGirl.create(:url, address: 'http://test2.com')
    UrlCheckService.new.perform
    expect(check_calls_count).to eq 2
  end

  it 'should remove all urls which are marked_for_deletion?' do
    Url.any_instance.stub(:check!)
    Url.any_instance.stub(:marked_for_deletion?) { |o| o.id.odd? }

    FactoryGirl.create(:url)
    FactoryGirl.create(:url, address: 'http://test2.com')
    expect { UrlCheckService.new.perform }.to change { Url.count }.by -1
  end

end

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

require 'spec_helper'

describe Url do

  it 'should check for address uniqueness' do
    valid = FactoryGirl.build(:url)
    invalid = FactoryGirl.build(:url)

    expect {
      valid.save
      invalid.save
    }.to change { Url.count }.by 1

    expect(invalid.errors.full_messages.first).to eq 'This url is already in our dyno database'
  end

  it 'should trim ending slash from address' do
    url = FactoryGirl.create(:url, address: 'http://test.com/')
    expect(url.address[-1]).not_to eq '/'
  end

  context 'pinging' do
    let!(:url) { FactoryGirl.create(:url, pinged: 0) }

    it 'should bump ping counter' do
      url.ping!
      expect(url.pinged).to eq 1
    end

    it 'should call pinging service' do
      expect_any_instance_of(WakefileExistenceService).to receive(:wake_file_founded?)
      url.ping!
    end
  end

  context 'checking' do
    let!(:url) { FactoryGirl.create(:url, marked_for_deletion: false) }

    it 'should change mark_for_deletion' do
      WakefileExistenceService.any_instance.stub(:wake_file_founded?).and_return(false)
      url.check!
      expect(url.reload.marked_for_deletion).to be_truthy
    end

    it 'should call pinging service' do
      expect_any_instance_of(WakefileExistenceService).to receive(:wake_file_founded?)
      url.check!
    end
  end

end

require 'spec_helper'

describe UrlsController do

  it 'should render get new' do
    get :new
    expect(response.status).to eq 200
  end

  it 'should create url' do
    expect {
      post :create, url: FactoryGirl.attributes_for(:url)
    }.to change { Url.count }.by 1
    expect(response).to redirect_to(root_path)
    expect(flash.notice).to eq 'Url was successfully added to our dyno database!'
  end

  it 'should not create url lack of wakemydyno.txt file' do
    expect {
      post :create, url: FactoryGirl.attributes_for(:no_file_url)
    }.not_to change { Url.count }
    expect(response).to render_template(:new)
  end

  it 'should not create url invalid address' do
    expect {
      post :create, url: {address: 'not_url_at_all'}
    }.not_to change { Url.count }
    expect(response).to render_template(:new)
  end

end

require 'test_helper'

class UrlsControllerTest < ActionController::TestCase

  test "should get new" do
    get :new
    assert_response :success
    assert_template :new
  end

  test "should create url" do
    assert_difference('Url.count') do
      post :create, url: FactoryGirl.attributes_for(:url)
    end

    assert_redirected_to root_path, 'root'
    assert_equal 'Url was successfully added to our dyno database!', flash[:notice]
  end

  test "should not create url lack of wakemydyno.txt file" do
    assert_no_difference('Url.count') do
      post :create, url: FactoryGirl.attributes_for(:no_file_url)
    end
    assert_response :success
    assert_template :new
  end

  test "should not create url invalid address" do

    post :create, url: {address: 'not_url_at_all'}

    assert_response :success
    assert_template :new
  end
end

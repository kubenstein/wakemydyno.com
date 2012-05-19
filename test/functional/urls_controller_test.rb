require 'test_helper'

class UrlsControllerTest < ActionController::TestCase
  setup do
    @ping = pings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:urls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ping" do
    assert_difference('Url.count') do
      post :create, ping: { counter: @ping.counter, mark_for_deletion: @ping.mark_for_deletion, url: @ping.url }
    end

    assert_redirected_to ping_path(assigns(:ping))
  end

  test "should show ping" do
    get :show, id: @ping
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ping
    assert_response :success
  end

  test "should update ping" do
    put :update, id: @ping, ping: { counter: @ping.counter, mark_for_deletion: @ping.mark_for_deletion, url: @ping.url }
    assert_redirected_to ping_path(assigns(:ping))
  end

  test "should destroy ping" do
    assert_difference('Url.count', -1) do
      delete :destroy, id: @ping
    end

    assert_redirected_to pings_path
  end
end

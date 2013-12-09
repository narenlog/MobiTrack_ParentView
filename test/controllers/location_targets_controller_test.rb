require 'test_helper'

class LocationTargetsControllerTest < ActionController::TestCase
  setup do
    @location_target = location_targets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:location_targets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location_target" do
    assert_difference('LocationTarget.count') do
      post :create, location_target: { address: @location_target.address, description: @location_target.description, latitude: @location_target.latitude, longitude: @location_target.longitude, title: @location_target.title }
    end

    assert_redirected_to location_target_path(assigns(:location_target))
  end

  test "should show location_target" do
    get :show, id: @location_target
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @location_target
    assert_response :success
  end

  test "should update location_target" do
    patch :update, id: @location_target, location_target: { address: @location_target.address, description: @location_target.description, latitude: @location_target.latitude, longitude: @location_target.longitude, title: @location_target.title }
    assert_redirected_to location_target_path(assigns(:location_target))
  end

  test "should destroy location_target" do
    assert_difference('LocationTarget.count', -1) do
      delete :destroy, id: @location_target
    end

    assert_redirected_to location_targets_path
  end
end

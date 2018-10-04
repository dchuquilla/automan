require 'test_helper'

class UserCarSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_car_setting = user_car_settings(:one)
  end

  test "should get index" do
    get _user_car_settings_url
    assert_response :success
  end

  test "should get new" do
    get new__user_car_setting_url
    assert_response :success
  end

  test "should create user_car_setting" do
    assert_difference('UserCarSetting.count') do
      post _user_car_settings_url, params: { user_car_setting: {  } }
    end

    assert_redirected_to user_car_setting_url(UserCarSetting.last)
  end

  test "should show user_car_setting" do
    get _user_car_setting_url(@user_car_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit__user_car_setting_url(@user_car_setting)
    assert_response :success
  end

  test "should update user_car_setting" do
    patch _user_car_setting_url(@user_car_setting), params: { user_car_setting: {  } }
    assert_redirected_to user_car_setting_url(@user_car_setting)
  end

  test "should destroy user_car_setting" do
    assert_difference('UserCarSetting.count', -1) do
      delete _user_car_setting_url(@user_car_setting)
    end

    assert_redirected_to _user_car_settings_url
  end
end

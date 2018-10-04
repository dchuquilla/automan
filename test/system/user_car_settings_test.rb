require "application_system_test_case"

class UserCarSettingsTest < ApplicationSystemTestCase
  setup do
    @user_car_setting = user_car_settings(:one)
  end

  test "visiting the index" do
    visit user_car_settings_url
    assert_selector "h1", text: "User Car Settings"
  end

  test "creating a User car setting" do
    visit user_car_settings_url
    click_on "New User Car Setting"

    click_on "Create User car setting"

    assert_text "User car setting was successfully created"
    click_on "Back"
  end

  test "updating a User car setting" do
    visit user_car_settings_url
    click_on "Edit", match: :first

    click_on "Update User car setting"

    assert_text "User car setting was successfully updated"
    click_on "Back"
  end

  test "destroying a User car setting" do
    visit user_car_settings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User car setting was successfully destroyed"
  end
end

require "application_system_test_case"

class MaintenanceHistoriesTest < ApplicationSystemTestCase
  setup do
    @maintenance_history = maintenance_histories(:one)
  end

  test "visiting the index" do
    visit maintenance_histories_url
    assert_selector "h1", text: "Maintenance Histories"
  end

  test "creating a Maintenance history" do
    visit maintenance_histories_url
    click_on "New Maintenance History"

    fill_in "Car", with: @maintenance_history.car_id
    fill_in "Cost", with: @maintenance_history.cost
    fill_in "Estimated Km", with: @maintenance_history.estimated_km
    fill_in "Notified", with: @maintenance_history.notified
    fill_in "Provider", with: @maintenance_history.provider
    fill_in "Review Date", with: @maintenance_history.review_date
    fill_in "Review Km", with: @maintenance_history.review_km
    fill_in "Scheduled Date", with: @maintenance_history.scheduled_date
    fill_in "Status", with: @maintenance_history.status
    click_on "Create Maintenance history"

    assert_text "Maintenance history was successfully created"
    click_on "Back"
  end

  test "updating a Maintenance history" do
    visit maintenance_histories_url
    click_on "Edit", match: :first

    fill_in "Car", with: @maintenance_history.car_id
    fill_in "Cost", with: @maintenance_history.cost
    fill_in "Estimated Km", with: @maintenance_history.estimated_km
    fill_in "Notified", with: @maintenance_history.notified
    fill_in "Provider", with: @maintenance_history.provider
    fill_in "Review Date", with: @maintenance_history.review_date
    fill_in "Review Km", with: @maintenance_history.review_km
    fill_in "Scheduled Date", with: @maintenance_history.scheduled_date
    fill_in "Status", with: @maintenance_history.status
    click_on "Update Maintenance history"

    assert_text "Maintenance history was successfully updated"
    click_on "Back"
  end

  test "destroying a Maintenance history" do
    visit maintenance_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Maintenance history was successfully destroyed"
  end
end

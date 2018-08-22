require "application_system_test_case"

class CostDetailsTest < ApplicationSystemTestCase
  setup do
    @cost_detail = cost_details(:one)
  end

  test "visiting the index" do
    visit cost_details_url
    assert_selector "h1", text: "Cost Details"
  end

  test "creating a Cost detail" do
    visit cost_details_url
    click_on "New Cost Detail"

    fill_in "Cost", with: @cost_detail.cost
    fill_in "Cost Type", with: @cost_detail.cost_type
    fill_in "Maintenance History", with: @cost_detail.maintenance_history_id
    fill_in "Provider", with: @cost_detail.provider
    click_on "Create Cost detail"

    assert_text "Cost detail was successfully created"
    click_on "Back"
  end

  test "updating a Cost detail" do
    visit cost_details_url
    click_on "Edit", match: :first

    fill_in "Cost", with: @cost_detail.cost
    fill_in "Cost Type", with: @cost_detail.cost_type
    fill_in "Maintenance History", with: @cost_detail.maintenance_history_id
    fill_in "Provider", with: @cost_detail.provider
    click_on "Update Cost detail"

    assert_text "Cost detail was successfully updated"
    click_on "Back"
  end

  test "destroying a Cost detail" do
    visit cost_details_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cost detail was successfully destroyed"
  end
end

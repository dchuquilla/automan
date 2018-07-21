require 'test_helper'

class MaintenanceHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @maintenance_history = maintenance_histories(:one)
  end

  test "should get index" do
    get maintenance_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_maintenance_history_url
    assert_response :success
  end

  test "should create maintenance_history" do
    assert_difference('MaintenanceHistory.count') do
      post maintenance_histories_url, params: { maintenance_history: { car_id: @maintenance_history.car_id, cost: @maintenance_history.cost, estimated_km: @maintenance_history.estimated_km, notified: @maintenance_history.notified, provider: @maintenance_history.provider, review_date: @maintenance_history.review_date, review_km: @maintenance_history.review_km, scheduled_date: @maintenance_history.scheduled_date, status: @maintenance_history.status } }
    end

    assert_redirected_to maintenance_history_url(MaintenanceHistory.last)
  end

  test "should show maintenance_history" do
    get maintenance_history_url(@maintenance_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_maintenance_history_url(@maintenance_history)
    assert_response :success
  end

  test "should update maintenance_history" do
    patch maintenance_history_url(@maintenance_history), params: { maintenance_history: { car_id: @maintenance_history.car_id, cost: @maintenance_history.cost, estimated_km: @maintenance_history.estimated_km, notified: @maintenance_history.notified, provider: @maintenance_history.provider, review_date: @maintenance_history.review_date, review_km: @maintenance_history.review_km, scheduled_date: @maintenance_history.scheduled_date, status: @maintenance_history.status } }
    assert_redirected_to maintenance_history_url(@maintenance_history)
  end

  test "should destroy maintenance_history" do
    assert_difference('MaintenanceHistory.count', -1) do
      delete maintenance_history_url(@maintenance_history)
    end

    assert_redirected_to maintenance_histories_url
  end
end

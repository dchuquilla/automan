require 'test_helper'

class CostDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cost_detail = cost_details(:one)
  end

  test "should get index" do
    get cost_details_url
    assert_response :success
  end

  test "should get new" do
    get new_cost_detail_url
    assert_response :success
  end

  test "should create cost_detail" do
    assert_difference('CostDetail.count') do
      post cost_details_url, params: { cost_detail: { cost: @cost_detail.cost, cost_type: @cost_detail.cost_type, maintenance_history_id: @cost_detail.maintenance_history_id, provider: @cost_detail.provider } }
    end

    assert_redirected_to cost_detail_url(CostDetail.last)
  end

  test "should show cost_detail" do
    get cost_detail_url(@cost_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_cost_detail_url(@cost_detail)
    assert_response :success
  end

  test "should update cost_detail" do
    patch cost_detail_url(@cost_detail), params: { cost_detail: { cost: @cost_detail.cost, cost_type: @cost_detail.cost_type, maintenance_history_id: @cost_detail.maintenance_history_id, provider: @cost_detail.provider } }
    assert_redirected_to cost_detail_url(@cost_detail)
  end

  test "should destroy cost_detail" do
    assert_difference('CostDetail.count', -1) do
      delete cost_detail_url(@cost_detail)
    end

    assert_redirected_to cost_details_url
  end
end

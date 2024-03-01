require "test_helper"

class NonconformitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nonconformity = nonconformities(:one)
  end

  test "should get index" do
    get nonconformities_url
    assert_response :success
  end

  test "should get new" do
    get new_nonconformity_url
    assert_response :success
  end

  test "should create nonconformity" do
    assert_difference("Nonconformity.count") do
      post nonconformities_url, params: { nonconformity: { Vehicles_id: @nonconformity.Vehicles_id, measures: @nonconformity.measures, nonconformityLevels: @nonconformity.nonconformityLevels, nonconformityLocals: @nonconformity.nonconformityLocals, nonconformityTypes: @nonconformity.nonconformityTypes, quadrants: @nonconformity.quadrants, vehicleParts: @nonconformity.vehicleParts } }
    end

    assert_redirected_to nonconformity_url(Nonconformity.last)
  end

  test "should show nonconformity" do
    get nonconformity_url(@nonconformity)
    assert_response :success
  end

  test "should get edit" do
    get edit_nonconformity_url(@nonconformity)
    assert_response :success
  end

  test "should update nonconformity" do
    patch nonconformity_url(@nonconformity), params: { nonconformity: { Vehicles_id: @nonconformity.Vehicles_id, measures: @nonconformity.measures, nonconformityLevels: @nonconformity.nonconformityLevels, nonconformityLocals: @nonconformity.nonconformityLocals, nonconformityTypes: @nonconformity.nonconformityTypes, quadrants: @nonconformity.quadrants, vehicleParts: @nonconformity.vehicleParts } }
    assert_redirected_to nonconformity_url(@nonconformity)
  end

  test "should destroy nonconformity" do
    assert_difference("Nonconformity.count", -1) do
      delete nonconformity_url(@nonconformity)
    end

    assert_redirected_to nonconformities_url
  end
end

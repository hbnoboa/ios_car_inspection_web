require "test_helper"

class VehiclePartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vehicle_part = vehicle_parts(:one)
  end

  test "should get index" do
    get vehicle_parts_url
    assert_response :success
  end

  test "should get new" do
    get new_vehicle_part_url
    assert_response :success
  end

  test "should create vehicle_part" do
    assert_difference("VehiclePart.count") do
      post vehicle_parts_url, params: { vehicle_part: { area: @vehicle_part.area, name: @vehicle_part.name } }
    end

    assert_redirected_to vehicle_part_url(VehiclePart.last)
  end

  test "should show vehicle_part" do
    get vehicle_part_url(@vehicle_part)
    assert_response :success
  end

  test "should get edit" do
    get edit_vehicle_part_url(@vehicle_part)
    assert_response :success
  end

  test "should update vehicle_part" do
    patch vehicle_part_url(@vehicle_part), params: { vehicle_part: { area: @vehicle_part.area, name: @vehicle_part.name } }
    assert_redirected_to vehicle_part_url(@vehicle_part)
  end

  test "should destroy vehicle_part" do
    assert_difference("VehiclePart.count", -1) do
      delete vehicle_part_url(@vehicle_part)
    end

    assert_redirected_to vehicle_parts_url
  end
end

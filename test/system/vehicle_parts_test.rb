require "application_system_test_case"

class VehiclePartsTest < ApplicationSystemTestCase
  setup do
    @vehicle_part = vehicle_parts(:one)
  end

  test "visiting the index" do
    visit vehicle_parts_url
    assert_selector "h1", text: "Vehicle parts"
  end

  test "should create vehicle part" do
    visit vehicle_parts_url
    click_on "New vehicle part"

    fill_in "Area", with: @vehicle_part.area
    fill_in "Name", with: @vehicle_part.name
    click_on "Create Vehicle part"

    assert_text "Vehicle part was successfully created"
    click_on "Back"
  end

  test "should update Vehicle part" do
    visit vehicle_part_url(@vehicle_part)
    click_on "Edit this vehicle part", match: :first

    fill_in "Area", with: @vehicle_part.area
    fill_in "Name", with: @vehicle_part.name
    click_on "Update Vehicle part"

    assert_text "Vehicle part was successfully updated"
    click_on "Back"
  end

  test "should destroy Vehicle part" do
    visit vehicle_part_url(@vehicle_part)
    click_on "Destroy this vehicle part", match: :first

    assert_text "Vehicle part was successfully destroyed"
  end
end

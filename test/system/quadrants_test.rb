require "application_system_test_case"

class QuadrantsTest < ApplicationSystemTestCase
  setup do
    @quadrant = quadrants(:one)
  end

  test "visiting the index" do
    visit quadrants_url
    assert_selector "h1", text: "Quadrants"
  end

  test "should create quadrant" do
    visit quadrants_url
    click_on "New quadrant"

    fill_in "Option", with: @quadrant.option
    click_on "Create Quadrant"

    assert_text "Quadrant was successfully created"
    click_on "Back"
  end

  test "should update Quadrant" do
    visit quadrant_url(@quadrant)
    click_on "Edit this quadrant", match: :first

    fill_in "Option", with: @quadrant.option
    click_on "Update Quadrant"

    assert_text "Quadrant was successfully updated"
    click_on "Back"
  end

  test "should destroy Quadrant" do
    visit quadrant_url(@quadrant)
    click_on "Destroy this quadrant", match: :first

    assert_text "Quadrant was successfully destroyed"
  end
end

require "application_system_test_case"

class MeasuresTest < ApplicationSystemTestCase
  setup do
    @measure = measures(:one)
  end

  test "visiting the index" do
    visit measures_url
    assert_selector "h1", text: "Measures"
  end

  test "should create measure" do
    visit measures_url
    click_on "New measure"

    fill_in "Size", with: @measure.size
    click_on "Create Measure"

    assert_text "Measure was successfully created"
    click_on "Back"
  end

  test "should update Measure" do
    visit measure_url(@measure)
    click_on "Edit this measure", match: :first

    fill_in "Size", with: @measure.size
    click_on "Update Measure"

    assert_text "Measure was successfully updated"
    click_on "Back"
  end

  test "should destroy Measure" do
    visit measure_url(@measure)
    click_on "Destroy this measure", match: :first

    assert_text "Measure was successfully destroyed"
  end
end

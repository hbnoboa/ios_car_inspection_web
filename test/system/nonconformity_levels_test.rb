require "application_system_test_case"

class NonconformityLevelsTest < ApplicationSystemTestCase
  setup do
    @nonconformity_level = nonconformity_levels(:one)
  end

  test "visiting the index" do
    visit nonconformity_levels_url
    assert_selector "h1", text: "Nonconformity levels"
  end

  test "should create nonconformity level" do
    visit nonconformity_levels_url
    click_on "New nonconformity level"

    fill_in "Level", with: @nonconformity_level.level
    click_on "Create Nonconformity level"

    assert_text "Nonconformity level was successfully created"
    click_on "Back"
  end

  test "should update Nonconformity level" do
    visit nonconformity_level_url(@nonconformity_level)
    click_on "Edit this nonconformity level", match: :first

    fill_in "Level", with: @nonconformity_level.level
    click_on "Update Nonconformity level"

    assert_text "Nonconformity level was successfully updated"
    click_on "Back"
  end

  test "should destroy Nonconformity level" do
    visit nonconformity_level_url(@nonconformity_level)
    click_on "Destroy this nonconformity level", match: :first

    assert_text "Nonconformity level was successfully destroyed"
  end
end

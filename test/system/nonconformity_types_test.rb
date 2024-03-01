require "application_system_test_case"

class NonconformityTypesTest < ApplicationSystemTestCase
  setup do
    @nonconformity_type = nonconformity_types(:one)
  end

  test "visiting the index" do
    visit nonconformity_types_url
    assert_selector "h1", text: "Nonconformity types"
  end

  test "should create nonconformity type" do
    visit nonconformity_types_url
    click_on "New nonconformity type"

    fill_in "Nctype", with: @nonconformity_type.nctype
    click_on "Create Nonconformity type"

    assert_text "Nonconformity type was successfully created"
    click_on "Back"
  end

  test "should update Nonconformity type" do
    visit nonconformity_type_url(@nonconformity_type)
    click_on "Edit this nonconformity type", match: :first

    fill_in "Nctype", with: @nonconformity_type.nctype
    click_on "Update Nonconformity type"

    assert_text "Nonconformity type was successfully updated"
    click_on "Back"
  end

  test "should destroy Nonconformity type" do
    visit nonconformity_type_url(@nonconformity_type)
    click_on "Destroy this nonconformity type", match: :first

    assert_text "Nonconformity type was successfully destroyed"
  end
end

require "application_system_test_case"

class NonconformityLocalsTest < ApplicationSystemTestCase
  setup do
    @nonconformity_local = nonconformity_locals(:one)
  end

  test "visiting the index" do
    visit nonconformity_locals_url
    assert_selector "h1", text: "Nonconformity locals"
  end

  test "should create nonconformity local" do
    visit nonconformity_locals_url
    click_on "New nonconformity local"

    fill_in "Local", with: @nonconformity_local.local
    click_on "Create Nonconformity local"

    assert_text "Nonconformity local was successfully created"
    click_on "Back"
  end

  test "should update Nonconformity local" do
    visit nonconformity_local_url(@nonconformity_local)
    click_on "Edit this nonconformity local", match: :first

    fill_in "Local", with: @nonconformity_local.local
    click_on "Update Nonconformity local"

    assert_text "Nonconformity local was successfully updated"
    click_on "Back"
  end

  test "should destroy Nonconformity local" do
    visit nonconformity_local_url(@nonconformity_local)
    click_on "Destroy this nonconformity local", match: :first

    assert_text "Nonconformity local was successfully destroyed"
  end
end

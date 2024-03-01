require "test_helper"

class NonconformityLevelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nonconformity_level = nonconformity_levels(:one)
  end

  test "should get index" do
    get nonconformity_levels_url
    assert_response :success
  end

  test "should get new" do
    get new_nonconformity_level_url
    assert_response :success
  end

  test "should create nonconformity_level" do
    assert_difference("NonconformityLevel.count") do
      post nonconformity_levels_url, params: { nonconformity_level: { level: @nonconformity_level.level } }
    end

    assert_redirected_to nonconformity_level_url(NonconformityLevel.last)
  end

  test "should show nonconformity_level" do
    get nonconformity_level_url(@nonconformity_level)
    assert_response :success
  end

  test "should get edit" do
    get edit_nonconformity_level_url(@nonconformity_level)
    assert_response :success
  end

  test "should update nonconformity_level" do
    patch nonconformity_level_url(@nonconformity_level), params: { nonconformity_level: { level: @nonconformity_level.level } }
    assert_redirected_to nonconformity_level_url(@nonconformity_level)
  end

  test "should destroy nonconformity_level" do
    assert_difference("NonconformityLevel.count", -1) do
      delete nonconformity_level_url(@nonconformity_level)
    end

    assert_redirected_to nonconformity_levels_url
  end
end

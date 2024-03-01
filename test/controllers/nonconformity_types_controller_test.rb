require "test_helper"

class NonconformityTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nonconformity_type = nonconformity_types(:one)
  end

  test "should get index" do
    get nonconformity_types_url
    assert_response :success
  end

  test "should get new" do
    get new_nonconformity_type_url
    assert_response :success
  end

  test "should create nonconformity_type" do
    assert_difference("NonconformityType.count") do
      post nonconformity_types_url, params: { nonconformity_type: { nctype: @nonconformity_type.nctype } }
    end

    assert_redirected_to nonconformity_type_url(NonconformityType.last)
  end

  test "should show nonconformity_type" do
    get nonconformity_type_url(@nonconformity_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_nonconformity_type_url(@nonconformity_type)
    assert_response :success
  end

  test "should update nonconformity_type" do
    patch nonconformity_type_url(@nonconformity_type), params: { nonconformity_type: { nctype: @nonconformity_type.nctype } }
    assert_redirected_to nonconformity_type_url(@nonconformity_type)
  end

  test "should destroy nonconformity_type" do
    assert_difference("NonconformityType.count", -1) do
      delete nonconformity_type_url(@nonconformity_type)
    end

    assert_redirected_to nonconformity_types_url
  end
end

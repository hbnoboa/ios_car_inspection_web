require "test_helper"

class NonconformityLocalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nonconformity_local = nonconformity_locals(:one)
  end

  test "should get index" do
    get nonconformity_locals_url
    assert_response :success
  end

  test "should get new" do
    get new_nonconformity_local_url
    assert_response :success
  end

  test "should create nonconformity_local" do
    assert_difference("NonconformityLocal.count") do
      post nonconformity_locals_url, params: { nonconformity_local: { local: @nonconformity_local.local } }
    end

    assert_redirected_to nonconformity_local_url(NonconformityLocal.last)
  end

  test "should show nonconformity_local" do
    get nonconformity_local_url(@nonconformity_local)
    assert_response :success
  end

  test "should get edit" do
    get edit_nonconformity_local_url(@nonconformity_local)
    assert_response :success
  end

  test "should update nonconformity_local" do
    patch nonconformity_local_url(@nonconformity_local), params: { nonconformity_local: { local: @nonconformity_local.local } }
    assert_redirected_to nonconformity_local_url(@nonconformity_local)
  end

  test "should destroy nonconformity_local" do
    assert_difference("NonconformityLocal.count", -1) do
      delete nonconformity_local_url(@nonconformity_local)
    end

    assert_redirected_to nonconformity_locals_url
  end
end

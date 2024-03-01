require "test_helper"

class QuadrantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quadrant = quadrants(:one)
  end

  test "should get index" do
    get quadrants_url
    assert_response :success
  end

  test "should get new" do
    get new_quadrant_url
    assert_response :success
  end

  test "should create quadrant" do
    assert_difference("Quadrant.count") do
      post quadrants_url, params: { quadrant: { option: @quadrant.option } }
    end

    assert_redirected_to quadrant_url(Quadrant.last)
  end

  test "should show quadrant" do
    get quadrant_url(@quadrant)
    assert_response :success
  end

  test "should get edit" do
    get edit_quadrant_url(@quadrant)
    assert_response :success
  end

  test "should update quadrant" do
    patch quadrant_url(@quadrant), params: { quadrant: { option: @quadrant.option } }
    assert_redirected_to quadrant_url(@quadrant)
  end

  test "should destroy quadrant" do
    assert_difference("Quadrant.count", -1) do
      delete quadrant_url(@quadrant)
    end

    assert_redirected_to quadrants_url
  end
end

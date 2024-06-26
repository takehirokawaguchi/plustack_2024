require "test_helper"

class TopsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tops_index_url
    assert_response :success
  end

  test "should get create" do
    get tops_create_url
    assert_response :success
  end

  test "should get show" do
    get tops_show_url
    assert_response :success
  end

  test "should get update" do
    get tops_update_url
    assert_response :success
  end

  test "should get destroy" do
    get tops_destroy_url
    assert_response :success
  end
end

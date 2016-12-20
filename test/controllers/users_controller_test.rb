require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_index_url
    assert_response :success
  end

  test "should get edit" do
    get users_edit_url
    assert_response :success
  end

  test "should get profile" do
    get users_profile_url
    assert_response :success
  end

  test "should get matches" do
    get users_matches_url
    assert_response :success
  end

end

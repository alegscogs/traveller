require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { name: 'foo', email: 'foo@example.com', password: 'foo', password_confirmation: 'foo' } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should redirect edit to site_home" do
    get edit_user_url(@user)
    assert_redirected_to site_home_url
  end

  test "should redirect update to site_home" do
    patch user_url(@user), params: { user: {  } }
    assert_redirected_to site_home_url
  end

  test "should redirect destroy to site_home" do
    assert_no_difference('User.count') do
      delete user_url(@user)
    end

    assert_redirected_to site_home_url
  end

  test "should not create user without matching password confirmation" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { name: 'foo', email: 'foo@example.com', password: 'foo', password_confirmation: 'bar' }}
    end
  end
  
  test "should not create user with wrongly formatted email" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { name: 'foo', email: 'fooexample.com', password: 'foo', password_confirmation: 'foo' }}
    end
  end

end

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should log in" do
    post login_path, params: { session: { email: @user.email, password: 'secret' } }
    assert_equal session[:user_id], @user.id
  end

  test "should log in then log out" do
    post login_path, params: { session: { email: @user.email, password: 'secret' } }
    assert_equal session[:user_id], @user.id
    delete logout_path
    assert_not_equal session[:user_id], @user.id
  end
end

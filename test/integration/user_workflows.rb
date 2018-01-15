require 'test_helper'

class UserWorkflowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "after loggin in, a user can edit their posts" do
    post login_path, params: { session: { email: @user.email, password: 'secret' } }
    get edit_post_path(@user.posts.first)
    assert_response :success
    patch post_path(@user.posts.first), params: { post: { title: "some change or other" } }
    assert_equal "some change or other", @user.posts.first.title
    assert_redirected_to post_url(@user.posts.first)
  end
end

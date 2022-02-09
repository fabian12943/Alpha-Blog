require "test_helper"

class DeleteUserTest < ActionDispatch::IntegrationTest

  test "should delete a user" do
    user = users(:user_1)
    sign_in_as(user)

    assert_difference "User.count", -1, "Did not delete the user" do
      delete user_path(user)
    end

    assert_nil session[:user_id], "Did not clear session[:user_id] after deleting the user"
  end

end
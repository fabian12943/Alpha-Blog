require "test_helper"

class SignupUserTest < ActionDispatch::IntegrationTest

  test "should signup a new user" do
    get signup_path
    assert_response :success, "Did not get a successful response for GET #{signup_path}"

    assert_difference "User.count", 1, "Did not create a new user" do
      post users_path, params: { user: { first_name: Faker::Name.first_name,
                                         last_name: Faker::Name.last_name,
                                         username: Faker::Internet.unique.user_name,
                                         email: Faker::Internet.unique.email,
                                         password: "password" } }
    end

    assert_equal 1, ActionMailer::Base.deliveries.size, "Did not send welcome mail to new user"
    assert_equal session[:user_id], User.last.id, "Did not set session[:user_id] to the new user's id"
  end

end
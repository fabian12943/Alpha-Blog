require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = valid_user
  end

  def valid_user
    User.new( first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              username: Faker::Internet.unique.user_name,
              email: Faker::Internet.unique.email,
              password: "password")
  end

  test "user should be valid" do
    assert @user.valid?, "Did not validate user despite valid attributes: #{@user.errors.full_messages}."
  end

  test "first name should be given" do
    @user.first_name = nil
    assert_not @user.valid?, "Validated user despite missing first name."
  end
  
  test "first name should not be too short" do
    min_length = 2
    @user.first_name = "a" * (min_length - 1)
    assert_not @user.valid?, "Validated user despite first name shorter than #{min_length} characters."
  end
  
  test "first name should not be too long" do
    max_length = 25
    @user.first_name = "a" * (max_length + 1)
    assert_not @user.valid?, "Validated user despite first name longer than #{max_length} characters."
  end
  
  test "first name should be downcased before saving" do
    upcase_first_name = "TeSt"
    @user.first_name = upcase_first_name
    @user.save
    assert_equal upcase_first_name.downcase, @user.first_name, "Did not downcase first name before saving."
  end

  test "last name should be given" do
    @user.last_name = nil
    assert_not @user.valid?, "Validated user despite missing last name."
  end
  
  test "last name should not be too short" do
    min_length = 2
    @user.last_name = "a" * (min_length - 1)
    assert_not @user.valid?, "Validated user despite last name shorter than #{min_length} characters."
  end
  
  test "last name should not be too long" do
    max_length = 25
    @user.last_name = "a" * (max_length + 1)
    assert_not @user.valid?, "Validated user despite last name longer than #{max_length} characters."
  end

  test "last name should be downcased before saving" do
    upcase_last_name = "TeSt"
    @user.last_name = upcase_last_name
    @user.save
    assert_equal upcase_last_name.downcase, @user.last_name, "Did not downcase last name before saving."
  end

  test "username should be given" do
    @user.username = nil
    assert_not @user.valid?, "Validated user despite missing username."
  end

  test "username should be unique" do
    @user.username = users(:user_1).username
    assert_not @user.valid?, "Validated user despite duplicate username."
  end

  test "username should not be too short" do
    min_length = 2
    @user.username = "a" * (min_length - 1)
    assert_not @user.valid?, "Validated user despite username shorter than #{min_length} characters."
  end

  test "username should not be too long" do
    max_length = 25
    @user.username = "a" * (max_length + 1)
    assert_not @user.valid?, "Validated user despite username longer than #{max_length} characters."
  end

  test "email should be given" do
    @user.email = nil
    assert_not @user.valid?, "Validated user despite missing email."
  end

  test "email should be unique" do
    @user.email = users(:user_1).email
    assert_not @user.valid?, "Validated user despite duplicate email."
  end

  test "email should not be too long" do
    max_length = 100
    @user.email = "a" * (max_length + 1)
    assert_not @user.valid?, "Validated user despite email longer than #{max_length} characters."
  end

  test "email should have valid format" do
    @user.email = "invalid_email"
    assert_not @user.valid?, "Validated user despite invalid email format."
  end
  
  test "email should be downcased before saving" do
    upcase_email = "TEsT@eXAMple.DE"
    @user.email = upcase_email
    @user.save
    assert_equal upcase_email.downcase, @user.email, "Did not downcase email before saving."
  end

  test "password should be given" do
    @user.password = nil
    assert_not @user.valid?, "Validated user despite missing password."
  end

  test "password should not be too short" do
    min_length = 6
    @user.password = "a" * (min_length - 1)
    assert_not @user.valid?, "Validated user despite password shorter than #{min_length} characters."
  end

  test "password should be hashed before saving" do
    @user.save
    assert BCrypt::Password.new(@user.password_digest).is_password?(@user.password), "Did not hash password before saving."
  end

end
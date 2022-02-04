require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest

  setup do
    @category = categories(:first)
    sign_in_as users(:admin)
  end

  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success
    assert_difference "Category.count", 1 do
      post categories_path, params: { category: { name: "NewTag" } }
    end
    assert_response :redirect
    follow_redirect!
    assert_select ".card-title", "NewTag"
  end

  test "reject get new category form if not admin" do
    sign_in_as users(:user_1)
    get "/categories/new"
    assert_response :redirect
  end

  test "reject create category if not admin" do
    sign_in_as users(:user_1)
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: "NewTag" } }
    end
  end

  test "get new category form and reject blank name" do
    blank_name = { category: { name: " " } }
    get_new_category_form_and_reject_invalid_category_submission(blank_name, "Name can't be blank")
  end

  test "get new category form and reject duplicate name" do
    duplicate_name = { category: { name: @category.name } }
    get_new_category_form_and_reject_invalid_category_submission(duplicate_name, "Name has already been taken")
  end

  def get_new_category_form_and_reject_invalid_category_submission(submission, expected_error_message)
    get "/categories/new"
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_path, params: submission
    end
    assert_response :success
    assert_select ".alert-danger"
    assert_select "#name+.invalid-feedback>.ul>.li", expected_error_message
  end

end

require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @category = categories(:first)
    sign_in_as users(:admin)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post categories_url, params: { category: { name: "New" } }
    end
    assert_redirected_to categories_url
  end

  test "should get edit" do
    get edit_category_url(@category)
    assert_response :success
  end

  test "should update category" do
    assert_changes '@category.reload.name', from: @category.name, to: "Updated" do
      patch category_url(@category), params: { category: { name: "Updated" } }
    end
    assert_redirected_to categories_url
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete category_url(@category)
    end
    assert_redirected_to categories_url
  end

end

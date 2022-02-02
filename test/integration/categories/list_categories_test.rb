require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  
  test "should display categories listing" do
    get categories_path

    assert_response :success
    assert_select ".card", Category.count, "This page must contain #{Category.count} category cards"
  end

  test "should display message if no catagories available" do
    Category.delete_all
    get categories_path

    assert_response :success
    assert_match "No categories created so far.", response.body, "This page must contain a message saying 'No categories created so far.'"
    assert_select ".card", false, "This page must contain no category cards"
  end

  test "should display paginator if page limit is reached" do
    Category.delete_all
    get categories_path
    
    assert_response :success

    (1..Category::PAGE_LIMIT+1).each do |i|
      Category.create!(name: "Category #{i}")
      get categories_path
      if i <= Category::PAGE_LIMIT
        assert_select "nav>.pagination>.page-item", false, "This page must not contain a paginator if the page limit of categories is not reached"
      end
    end

    assert_select "nav>.pagination>.page-item", true, "This page must contain a paginator"
  end


end

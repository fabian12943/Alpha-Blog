require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:user_1)
  end

  def valid_article_params
    { title: "Title", 
      description: "Description of the Article", 
      content: "Content of the Article that is longer than the description",
      user: users(:user_1)
    }
  end

  test "should create a new article" do
    get new_article_path
    assert_response :success, "Did not get a successful response for GET #{new_article_path}"

    assert_difference "Article.count", 1, "Did not create a new article" do
      post articles_path, params: { article: valid_article_params }
      Article.last.categories << Category.first
    end

    assert_response :redirect
    follow_redirect!

    assert_select ".category-tag", Category.first.name
    assert_select ".card-title", valid_article_params.fetch(:title)
    assert_select ".card-body .user-link", users(:user_1).first_name + " " + users(:user_1).last_name
    assert_select ".card-text", valid_article_params.fetch(:content)
  end

end
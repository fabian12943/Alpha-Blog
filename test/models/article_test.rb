require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  setup do 
    @article = valid_article
  end

  def valid_article
    Article.new(title: "Valid Title",
                description: "Valid Description",
                user: User.first)
  end

  test "article should be valid" do
    assert @article.valid?, "Did not validate article despite valid attributes: #{@article.errors.full_messages}."
  end

  test "title should be given" do
    @article.title = nil
    assert_not @article.valid?, "Validated article despite missing title."
  end
  
  test "title should not be too short" do
    min_length = 5
    @article.title = "a" * (min_length - 1)
    assert_not @article.valid?, "Validated article despite title shorter than #{min_length} characters."
  end

  test "title should not be too long" do
    max_length = 120
    @article.title = "a" * (max_length + 1)
    assert_not @article.valid?, "Validated article despite title longer than #{max_length} characters."
  end

  test "description should be given" do
    @article.description = nil
    assert_not @article.valid?, "Validated article despite missing description."
  end

  test "description should not be too short" do
    min_length = 10
    @article.description = "a" * (min_length - 1)
    assert_not @article.valid?, "Validated article despite description shorter than #{min_length} characters."
  end
  
  test "description should not be too long" do
    max_length = 10000
    @article.description = "a" * (max_length + 1)
    assert_not @article.valid?, "Validated article despite description longer than #{max_length} characters."
  end
  
  test "author should be given" do
    @article.user = nil
    assert_not @article.valid?, "Validated article despite missing author."
  end

end
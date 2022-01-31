require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  test "category should be valid" do
    category = Category.new(name: "Valid Category") 
    assert category.valid?, "Did not validate category despite valid attributes: #{category.errors.full_messages}."
  end
  
  test "name should be given" do
    category = Category.new
    assert_not category.valid?, "Validated category despite missing name."
  end

  test "name should not be blank" do
    category = Category.new(name: " ")
    assert_not category.valid?, "Validated category despite empty name."
  end

  test "name should be unique" do
    category = Category.new(name: categories(:first).name)
    assert_not category.valid?, "Validated category despite duplicate name."
  end

  test "name should not be too short" do
    min_length = 2
    category = Category.new(name: "a" * (min_length - 1))
    assert_not category.valid?, "Validated category despite name shorter than #{min_length} characters."
  end

  test "name should not be too long" do
    max_length = 15
    category = Category.new(name: "a" * (max_length + 1))
    assert_not category.valid?, "Validated category despite name longer than #{max_length} characters."
  end

end
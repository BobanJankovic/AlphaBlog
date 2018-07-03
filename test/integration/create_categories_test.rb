require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
 

  test "get new category form and create category" do
    
    get new_category_path
    
    assert_template 'categories/new'
    #create action
    assert_difference 'Category.count', 1 do
      post categories_path, params: {category: {name:"football"} }
      #PUSI GA LINU 14
      follow_redirect!
    end
    assert_template 'categories/index'
    assert_match "football", response.body
  end
end
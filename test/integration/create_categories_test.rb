require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name:"sports")
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end
  
  def sign_in_as(user, password)
    post login_path, params: { session: { email: user.email, password: password } }
  end


  test "get new category form and create category" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    #create action
    assert_difference 'Category.count', 1 do
      post categories_path, params: {category: {name:"football"} }
      follow_redirect!
    end
    assert_template 'categories/index'
    assert_match "football", response.body
  end

  test "invalid category submission results in failure" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name:" "} }
    end
    assert_template 'categories/new'
    assert_select 'h2.card-title'
    assert_select 'p.card-text'
  end

 

end
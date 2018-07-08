require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest


  def setup
    @category = Category.new(name: "sports")
    @category.id=1
    @category.save
    @article = Article.new(title: "sports", description:"hghghghghghghg",user_id:1, category_ids: [1])
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end

  
  def sign_in_as(user, password)
    post login_path, params: { session: { email: user.email, password: password } }
  end


  test "get new article form and create article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    #create action
    assert_difference 'Article.count', 1 do
      post articles_path, params: {article: {title: "sports", description:"hghghghghghghg"} }
      follow_redirect!
    end
    assert_template 'articles/show'
    assert_match "sports", response.body
  end

end
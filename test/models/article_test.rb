require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "sports")
    @category.id=1
    @category.save
    @article = Article.new(title: "sports", description:"hghghghghghghg",user_id:1, category_ids: [1])
    
  end
 
 
  test "article should be valid" do
   
    assert @article.valid?
  end


  test "name should be present" do
    @article.title = " "
    assert_not @article.valid?
  end
  test "name should not be too long" do
    @article.title = "a" * 56
    assert_not @article.valid?
  end
 
end

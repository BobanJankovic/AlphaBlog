require 'test_helper'

class CreateUsersTest < ActionDispatch::IntegrationTest

  test "create new user" do
   
    get signup_path
    assert_template 'users/new'
    #create action
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {username: "johnfff", email: "johddn@example.com", password: "password"} }
      follow_redirect!
    end
    assert_template 'users/show'
    assert_match "johnfff", response.body
  end


end
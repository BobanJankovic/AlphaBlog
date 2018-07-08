require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.create(username: "bobki", email:"boban00092@gmail.com", password:"password")
  end

  test "usershould be valid" do
    assert @user.valid?
  end

end
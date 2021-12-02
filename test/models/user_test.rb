require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:admin)
    @user2 = users(:normal_user)
  end

  test "should be valid - for admin account" do
    assert @user.valid?
  end

  test "name should be present - for admin account" do
    assert_equal("Admin Account", @user.first_name+" "+@user.last_name)
    assert @user.valid?
  end

  test "should be valid - for normal user account" do
    assert @user.valid?
  end

  test "name should be present - for normal user account" do
    assert_equal("Admin Account", @user.first_name+" "+@user.last_name)
    assert @user.valid?
  end

  # test "should create valid user" do
  #   user = User.new
  #   user.first_name = "First"
  #   user.last_name = "Last"
  #   user.id = "4"
  #   user.email = "FirstLast@email.com"
  #   user.created_at = "2021-11-28 12:36:47.369433000 +0000"
  #   user.updated_at = "2021-11-28 12:36:47.369433000 +0000"

  #   user.save!
  #   assert user.valid?
  # end

end

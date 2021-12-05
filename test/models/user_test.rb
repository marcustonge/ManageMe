require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:admin)
    @user2 = users(:normal_user)
  end

  #tests if the user is valid given the account being an admin or normal account
  #and if the name of the user corresponds to their first and last name
  test "should be valid - for admin account" do
    assert @user.valid?
  end

  test "name should be present - for admin account" do
    assert_equal("Admin Account", @user.first_name+" "+@user.last_name)
    assert @user.valid?
  end

  test "should be valid - for normal user account" do
    assert @user2.valid?
  end

  test "name should be present - for normal user account" do
    assert_equal("Normal User", @user2.first_name+" "+@user2.last_name)
    assert @user2.valid?
  end

  #tests whether setting attributes works correctly
  test "should create valid user given attributes" do
    user = User.new
    user.first_name = "First"
    user.last_name = "Last"
    user.id = "4"
    user.email = "firstlast@email.com"
    user.save

    assert_equal "First", user.first_name
    assert_equal "Last", user.last_name
    assert_equal 4, user.id
    assert_equal "firstlast@email.com", user.email
    assert @user.valid?
  end

  test "should delete user account" do
    assert_difference("User.count",-1) do
      @user.destroy
    end
  end
end

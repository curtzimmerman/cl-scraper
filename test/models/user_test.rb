require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(email: "email2342@email.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "email should be present" do
  	@user.email = "  "
  	assert_not @user.valid?
  end

  test "email should be formatted" do
  	@user.email = "aj234@am@email.ee..com"
  	assert_not @user.valid?
  end

  test "password should be present" do
  	@user.password = "  "
  	assert_not @user.valid?
  end

  test "password should be longer than 6 characters" do
  	@user.password = "passw"
  	@user.password_confirmation = "passw"
  	assert_not @user.valid?
  end

end

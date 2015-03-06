require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  def setup
  	@user = User.new(name: "example user", email: "asd@asd.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do 
  	assert @user.valid?
  end

  test "nama harus terisi" do
  	@user.name = '    '
  	assert_not @user.valid?
  end


  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end


  test "length dari nama ga boleh lebih dari 50" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end



  test "length dari email ga boleh lebih dari 255" do
  	@user.email = "a" * 244 + "@example.com"
  	assert_not @user.valid?
  end



  test "email validation should accept valid addresses" do
  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  	valid_addresses.each do |valid|
  		@user.email = valid
  		assert @user.valid?, "#{valid.inspect} should be valid"  ## custom eror messages
  	end

  end



  test "email validation should reject invalid addresses" do
  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
  	invalid_addresses.each do |invalid|
  		@user.email = invalid
  		assert_not @user.valid?,"#{invalid.inspect} harusnya eror"  ## custom eror messages
  	end




  end




    test "email addresses should be unique" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      assert_not duplicate_user.valid?
    end


    test "password should have minimum length" do 
      @user.password = @user.password_confirmation = "a" * 5
      assert_not @user.valid?
    end




end

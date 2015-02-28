require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase


	def setup
	@base = "Ruby on Rails Tutorial Sample App"
	end




  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "#{@base}"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | #{@base}"
  end


  test "about pages harus ada" do 
  	get :about
  	assert_response :success
  	assert_select "title", "About | #{@base}"
  end

end

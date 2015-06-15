require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  
  def setup
  	@search = Search.new(title: "New Search", location: "New York", query: "cool stuff")
  end

  test "should be valid" do
  	assert @search.valid?
  end

  test "should have title" do
  	@search.title = "  "
  	assert_not @search.valid?
  end

  test "title should be less than 51 characters" do
  	@search.title = ('a' * 51)
  	assert_not @search.valid?
  end

  test "location should be present" do
  	@search.location = "  "
  	assert_not @search.valid?
  end

  test "query should be present" do
  	@search.query = "  "
  	assert_not @search.valid?
  end

  test "query should not be longer than 255 characters" do
  	@search.query = ('a' * 256)
  	assert_not @search.valid?
  end

end

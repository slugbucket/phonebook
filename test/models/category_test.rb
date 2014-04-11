require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should save a new category" do
    category = Category.new(:id => 10, :name => 'bob', :created_at => '2014-01-05 12:09:36', :updated_at => '2014-01-05 12:09:36')
    assert !category.save
  end
end

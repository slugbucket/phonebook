require 'test_helper'

class ExtensionRangesControllerTest < ActionController::TestCase
  setup do
    @extension_range = extension_ranges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:extension_ranges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extension_range" do
    assert_difference('ExtensionRange.count') do
      post :create, extension_range: { first_extension: @extension_range.first_extension, last_extension: @extension_range.last_extension }
    end

    assert_redirected_to extension_range_path(assigns(:extension_range))
  end

  test "should show extension_range" do
    get :show, id: @extension_range
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @extension_range
    assert_response :success
  end

  test "should update extension_range" do
    patch :update, id: @extension_range, extension_range: { first_extension: @extension_range.first_extension, last_extension: @extension_range.last_extension }
    assert_redirected_to extension_range_path(assigns(:extension_range))
  end

  test "should destroy extension_range" do
    assert_difference('ExtensionRange.count', -1) do
      delete :destroy, id: @extension_range
    end

    assert_redirected_to extension_ranges_path
  end
end

require 'test_helper'

class DaillingRightsControllerTest < ActionController::TestCase
  setup do
    @dailling_right = dailling_rights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dailling_rights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dailling_right" do
    assert_difference('DaillingRight.count') do
      post :create, dailling_right: { description: @dailling_right.description, name: @dailling_right.name }
    end

    assert_redirected_to dailling_right_path(assigns(:dailling_right))
  end

  test "should show dailling_right" do
    get :show, id: @dailling_right
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dailling_right
    assert_response :success
  end

  test "should update dailling_right" do
    patch :update, id: @dailling_right, dailling_right: { description: @dailling_right.description, name: @dailling_right.name }
    assert_redirected_to dailling_right_path(assigns(:dailling_right))
  end

  test "should destroy dailling_right" do
    assert_difference('DaillingRight.count', -1) do
      delete :destroy, id: @dailling_right
    end

    assert_redirected_to dailling_rights_path
  end
end

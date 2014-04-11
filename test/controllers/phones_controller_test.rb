require 'test_helper'

class PhonesControllerTest < ActionController::TestCase
  setup do
    @phone = phones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phones)
  end

  test "should get new" do
    get :new
    assert_response :failure
  end

  test "should not create phone" do
    post :create, phone: { firstname: @phone.firstname, surname: @phone.surname, uid: @phone.uid }
    assert_response :failure

    assert_redirected_to phone_path(assigns(:phone))
  end

  test "should show phone" do
    get :show, id: @phone
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @phone
    assert_response :success
  end

  test "should update phone" do
    patch :update, id: @phone, phone: { firstname: @phone.firstname, surname: @phone.surname, uid: @phone.uid }
    assert_redirected_to phone_path(assigns(:phone))
  end

  # We shoudl be prohibited from deleting a phone record
  test "should destroy phone" do
    delete :destroy, id: @phone
    assert_response :failure
  end
end

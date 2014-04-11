require 'test_helper'

class SubDepartmentsControllerTest < ActionController::TestCase
  setup do
    @sub_department = sub_departments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sub_departments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sub_department" do
    assert_difference('SubDepartment.count') do
      post :create, sub_department: { department_id: @sub_department.department_id, name: @sub_department.name, sub_department_code: @sub_department.sub_department_code  }
    end

    assert_redirected_to sub_department_path(assigns(:sub_department))
  end

  test "should show sub_department" do
    get :show, id: @sub_department
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sub_department
    assert_response :success
  end

  test "should update sub_department" do
    patch :update, id: @sub_department, sub_department: { department_id: @sub_department.department_id, name: @sub_department.name, sub_department_code: @sub_department.sub_department_code }
    assert_redirected_to sub_department_path(assigns(:sub_department))
  end

  test "should destroy sub_department" do
    assert_difference('SubDepartment.count', -1) do
      delete :destroy, id: @sub_department
    end

    assert_redirected_to sub_departments_path
  end
end

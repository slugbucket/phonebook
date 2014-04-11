class SubDepartmentsController < ApplicationController
  before_action :set_sub_department, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]
  load_and_authorize_resource :only => [:edit, :update]

  # GET /sub_departments
  # GET /sub_departments.json
  def index
    #@sub_departments = SubDepartment.all
    @sub_departments = SubDepartment.order("department_id, name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /sub_departments/1
  # GET /sub_departments/1.json
  def show
  end

  # GET /sub_departments/new
  def new
    @sub_department = SubDepartment.new
  end

  # GET /sub_departments/1/edit
  def edit
  end

  # POST /sub_departments
  # POST /sub_departments.json
  def create
    @sub_department = SubDepartment.new(sub_department_params)

    respond_to do |format|
      if @sub_department.save
        format.html { redirect_to @sub_department, notice: 'Sub department was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sub_department }
      else
        format.html { render action: 'new' }
        format.json { render json: @sub_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_departments/1
  # PATCH/PUT /sub_departments/1.json
  def update
    respond_to do |format|
      if @sub_department.update(sub_department_params)
        format.html { redirect_to @sub_department, notice: 'Sub department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sub_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_departments/1
  # DELETE /sub_departments/1.json
  def destroy
    @sub_department.destroy
    respond_to do |format|
      format.html { redirect_to sub_departments_url }
      format.json { head :no_content }
    end
  end

  # Custom action to return the default dialling right for the department used
  # to dynically update the phones dialling after selecting the sub-department
  # GET /sub_departments/1/default_dialling_right
  # GET /sub_departments/1/default_dialling_right.json
  def default_dialling_right
    @dept = Department.select(:default_dialling_right_id).joins(" INNER JOIN sub_departments ON departments.id = sub_departments.department_id").where(sub_departments: {id: params[:id]})

    respond_to do |format|
      format.html
      format.json { render json: @dept } 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_department
      @sub_department = SubDepartment.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_department_params
      params.require(:sub_department).permit(:name, :department_id, :sub_department_code, :preferred_extension_range_id)
  end
  def log_update
    dept = Department.dept_name(@sub_department.department_id)
    log_msg = "SubDepartment #{@sub_department.name} (#{@sub_department.id}) in #{dept}"
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @sub_department.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
  end
end

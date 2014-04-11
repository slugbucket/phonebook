class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  # GET /departments
  # GET /departments.json
  def index
    #@departments = Department.all
    @departments = Department.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
  end

  # GET /departments/new
  def new
    @department = Department.new
    authorize! :new, @department
  end

  # GET /departments/1/edit
  def edit
    authorize! :edit, @department
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)
    authorize! :create, @department

    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: 'Department was successfully created.' }
        format.json { render action: 'show', status: :created, location: @department }
      else
        format.html { render action: 'new' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    authorize! :update, @department   
    #Rails.logger.debug "UPDATE: before: #{department_params.inspect}"
    #@department[:extension_range_tokens].shift
    Rails.logger.debug "UPDATE: after: #{@department.inspect}"
    
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    authorize! :destroy, @department
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
      Rails.logger.debug "set_department: #{@department.inspect}"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params[:department][:extension_range_tokens].shift
      params.require(:department).permit(:name, :category_id, :department_code, :active, :default_dialling_right_id, extension_range_tokens: [])
  end
  def log_update
    cat = Category.category_name(@department.category_id)
    dr = DiallingRight.dialling_right_name(@department.default_dialling_right_id)
    log_msg = "id: #{@department.id}\nname: #{@department.name}\ncategory: #{cat}\n#{@department.department_code}\ndefault_dialling_right: #{dr}"
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @department.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
  end
end

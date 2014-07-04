class <%= class_name.pluralize %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]
  
  # GET /<%= table_name %> %>
  # GET /<%= table_name %>.json
  def index
    #@<%= table_name %> = <%= class_name %>.all
    @<%= table_name %> = <%= class_name %>.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /<%= table_name %>/1
  # GET /<%= table_name %>/1.json
  def show
  end
  
  # GET /<%= table_name %>/new
  def new
    @<%= singular_table_name %> = <%= class_name %>.new
    authorize! :new, @<%= singular_table_name %>
  end
  
  # GET /<%= table_name %>/1/edit
  def edit
    authorize! :edit, @<%= singular_table_name %>
  end
  
  # POST /<%= table_name %>
  # POST /<%= table_name %>.json
  def create
    @<%= singular_table_name %> = <%= class_name %>.new(<%= singular_table_name %>_params)
    authorize! :create, @<%= singular_table_name %>

    respond_to do |format|
      if @<%= singular_table_name %>.save
        format.html { redirect_to @<%= singular_table_name %>, notice: '<%= class_name.underscore %> was successfully created.' }
        format.json { render :show, status: :created, location: @<%= singular_table_name %> }
      else
        format.html { render :new }
        format.json { render json: @<%= singular_table_name %>.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /<%= table_name %>/1
  # PATCH/PUT /<%= table_name %>/1.json
  def update
    authorize! :update, @<%= singular_table_name %>
    respond_to do |format|
      if @<%= singular_table_name %>.update(<%= singular_table_name %>_params)
        format.html { redirect_to @<%= singular_table_name %>, notice: '<%= singular_table_name %> was successfully updated.' }
        format.json { render :show, status: :ok, location: @<%= singular_table_name %> }
      else
        format.html { render :edit }
        format.json { render json: @<%= singular_table_name %>.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /<%= table_name %>/1
  # DELETE /<%= table_name %>/1.json
  def destroy
    authorize! :destroy, @<%= singular_table_name %>
    @<%= singular_table_name %>.destroy
    respond_to do |format|
      format.html { redirect_to <%= table_name %>_url, notice: '<%= class_name.underscore %> was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= class_name %>.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def <%= singular_table_name %>_params
      params.require(:<%= singular_table_name %>).permit(:name)
    end
    def log_update
      log_msg = "id: #{@<%= singular_table_name %>.id}\nname: #{@<%= singular_table_name %>.name}" 
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @<%= singular_table_name %>.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end

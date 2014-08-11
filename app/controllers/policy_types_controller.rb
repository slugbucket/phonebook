class PolicyTypesController < ApplicationController
  before_action :set_policy_type, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "policies_layout"
  # GET /policy_types %>
  # GET /policy_types.json
  def index
    #@policy_types = PolicyType.all
    @policy_types = PolicyType.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /policy_types/1
  # GET /policy_types/1.json
  def show
  end
  
  # GET /policy_types/new
  def new
    @policy_type = PolicyType.new
    authorize! :new, @policy_type
  end
  
  # GET /policy_types/1/edit
  def edit
    authorize! :edit, @policy_type
  end
  
  # POST /policy_types
  # POST /policy_types.json
  def create
    @policy_type = PolicyType.new(policy_type_params)
    authorize! :create, @policy_type

    respond_to do |format|
      if @policy_type.save
        format.html { redirect_to @policy_type, notice: 'policy_type was successfully created.' }
        format.json { render :show, status: :created, location: @policy_type }
      else
        format.html { render :new }
        format.json { render json: @policy_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /policy_types/1
  # PATCH/PUT /policy_types/1.json
  def update
    authorize! :update, @policy_type
    respond_to do |format|
      if @policy_type.update(policy_type_params)
        format.html { redirect_to @policy_type, notice: 'policy_type was successfully updated.' }
        format.json { render :show, status: :ok, location: @policy_type }
      else
        format.html { render :edit }
        format.json { render json: @policy_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /policy_types/1
  # DELETE /policy_types/1.json
  def destroy
    authorize! :destroy, @policy_type
    @policy_type.destroy
    respond_to do |format|
      format.html { redirect_to policy_types_url, notice: 'policy_type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_policy_type
      @policy_type = PolicyType.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def policy_type_params
      params.require(:policy_type).permit(:name, :description, :policy_type_id)
    end
    def log_update
      log_msg = "id: #{@policy_type.id}\nname: #{@policy_type.name}\ndescription: #{@policy_type.description}" 
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @policy_type.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end

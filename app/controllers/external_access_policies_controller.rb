class ExternalAccessPoliciesController < ApplicationController
  before_action :set_external_access_policy, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "policies_layout"
  
  # GET /external_access_policies %>
  # GET /external_access_policies.json
  def index
    #@external_access_policies = ExternalAccessPolicy.all
    @external_access_policies = ExternalAccessPolicy.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /external_access_policies/1
  # GET /external_access_policies/1.json
  def show
  end
  
  # GET /external_access_policies/new
  def new
    @external_access_policy = ExternalAccessPolicy.new
    authorize! :new, @external_access_policy
  end
  
  # GET /external_access_policies/1/edit
  def edit
    authorize! :edit, @external_access_policy
  end
  
  # POST /external_access_policies
  # POST /external_access_policies.json
  def create
    @external_access_policy = ExternalAccessPolicy.new(external_access_policy_params)
    authorize! :create, @external_access_policy

    respond_to do |format|
      if @external_access_policy.save
        format.html { redirect_to @external_access_policy, notice: 'external_access_policy was successfully created.' }
        format.json { render :show, status: :created, location: @external_access_policy }
      else
        format.html { render :new }
        format.json { render json: @external_access_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /external_access_policies/1
  # PATCH/PUT /external_access_policies/1.json
  def update
    authorize! :update, @external_access_policy
    respond_to do |format|
      if @external_access_policy.update(external_access_policy_params)
        format.html { redirect_to @external_access_policy, notice: 'external_access_policy was successfully updated.' }
        format.json { render :show, status: :ok, location: @external_access_policy }
      else
        format.html { render :edit }
        format.json { render json: @external_access_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /external_access_policies/1
  # DELETE /external_access_policies/1.json
  def destroy
    authorize! :destroy, @external_access_policy
    @external_access_policy.destroy
    respond_to do |format|
      format.html { redirect_to external_access_policies_url, notice: 'external_access_policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_external_access_policy
      @external_access_policy = ExternalAccessPolicy.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def external_access_policy_params
      params.require(:external_access_policy).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@external_access_policy.id}\nname: #{@external_access_policy.name}\ndescription: #{@external_access_policy.description}" 
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @external_access_policy.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end

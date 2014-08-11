class DialPlanPoliciesController < ApplicationController
  before_action :set_dial_plan_policy, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "policies_layout"
  
  # GET /dial_plan_policies %>
  # GET /dial_plan_policies.json
  def index
    #@dial_plan_policies = DialPlanPolicy.all
    @dial_plan_policies = DialPlanPolicy.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /dial_plan_policies/1
  # GET /dial_plan_policies/1.json
  def show
  end
  
  # GET /dial_plan_policies/new
  def new
    @dial_plan_policy = DialPlanPolicy.new
    authorize! :new, @dial_plan_policy
  end
  
  # GET /dial_plan_policies/1/edit
  def edit
    authorize! :edit, @dial_plan_policy
  end
  
  # POST /dial_plan_policies
  # POST /dial_plan_policies.json
  def create
    @dial_plan_policy = DialPlanPolicy.new(dial_plan_policy_params)
    authorize! :create, @dial_plan_policy

    respond_to do |format|
      if @dial_plan_policy.save
        format.html { redirect_to @dial_plan_policy, notice: 'dial_plan_policy was successfully created.' }
        format.json { render :show, status: :created, location: @dial_plan_policy }
      else
        format.html { render :new }
        format.json { render json: @dial_plan_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dial_plan_policies/1
  # PATCH/PUT /dial_plan_policies/1.json
  def update
    authorize! :update, @dial_plan_policy
    respond_to do |format|
      if @dial_plan_policy.update(dial_plan_policy_params)
        format.html { redirect_to @dial_plan_policy, notice: 'dial_plan_policy was successfully updated.' }
        format.json { render :show, status: :ok, location: @dial_plan_policy }
      else
        format.html { render :edit }
        format.json { render json: @dial_plan_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dial_plan_policies/1
  # DELETE /dial_plan_policies/1.json
  def destroy
    authorize! :destroy, @dial_plan_policy
    @dial_plan_policy.destroy
    respond_to do |format|
      format.html { redirect_to dial_plan_policies_url, notice: 'dial_plan_policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dial_plan_policy
      @dial_plan_policy = DialPlanPolicy.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def dial_plan_policy_params
      params.require(:dial_plan_policy).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@dial_plan_policy.id}\nname: #{@dial_plan_policy.name}\ndescription: #{@dial_plan_policy.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @dial_plan_policy.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end

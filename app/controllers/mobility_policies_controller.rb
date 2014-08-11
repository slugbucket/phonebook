class MobilityPoliciesController < ApplicationController
  before_action :set_mobility_policy, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "policies_layout"

  # GET /mobility_policies %>
  # GET /mobility_policies.json
  def index
    #@mobility_policies = MobilityPolicy.all
    @mobility_policies = MobilityPolicy.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /mobility_policies/1
  # GET /mobility_policies/1.json
  def show
  end
  
  # GET /mobility_policies/new
  def new
    @mobility_policy = MobilityPolicy.new
    authorize! :new, @mobility_policy
  end
  
  # GET /mobility_policies/1/edit
  def edit
    authorize! :edit, @mobility_policy
  end
  
  # POST /mobility_policies
  # POST /mobility_policies.json
  def create
    @mobility_policy = MobilityPolicy.new(mobility_policy_params)
    authorize! :create, @mobility_policy

    respond_to do |format|
      if @mobility_policy.save
        format.html { redirect_to @mobility_policy, notice: 'mobility_policy was successfully created.' }
        format.json { render :show, status: :created, location: @mobility_policy }
      else
        format.html { render :new }
        format.json { render json: @mobility_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mobility_policies/1
  # PATCH/PUT /mobility_policies/1.json
  def update
    authorize! :update, @mobility_policy
    respond_to do |format|
      if @mobility_policy.update(mobility_policy_params)
        format.html { redirect_to @mobility_policy, notice: 'mobility_policy was successfully updated.' }
        format.json { render :show, status: :ok, location: @mobility_policy }
      else
        format.html { render :edit }
        format.json { render json: @mobility_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mobility_policies/1
  # DELETE /mobility_policies/1.json
  def destroy
    authorize! :destroy, @mobility_policy
    @mobility_policy.destroy
    respond_to do |format|
      format.html { redirect_to mobility_policies_url, notice: 'mobility_policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mobility_policy
      @mobility_policy = MobilityPolicy.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def mobility_policy_params
      params.require(:mobility_policy).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@mobility_policy.id}\nname: #{@mobility_policy.name}\ndescription: #{@mobility_policy.description}" 
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @mobility_policy.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end

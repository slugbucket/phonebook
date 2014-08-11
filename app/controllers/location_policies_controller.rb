class LocationPoliciesController < ApplicationController
  before_action :set_location_policy, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "policies_layout"
  
  # GET /location_policies %>
  # GET /location_policies.json
  def index
    #@location_policies = LocationPolicy.all
    @location_policies = LocationPolicy.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /location_policies/1
  # GET /location_policies/1.json
  def show
  end
  
  # GET /location_policies/new
  def new
    @location_policy = LocationPolicy.new
    authorize! :new, @location_policy
  end
  
  # GET /location_policies/1/edit
  def edit
    authorize! :edit, @location_policy
  end
  
  # POST /location_policies
  # POST /location_policies.json
  def create
    @location_policy = LocationPolicy.new(location_policy_params)
    authorize! :create, @location_policy

    respond_to do |format|
      if @location_policy.save
        format.html { redirect_to @location_policy, notice: 'location_policy was successfully created.' }
        format.json { render :show, status: :created, location: @location_policy }
      else
        format.html { render :new }
        format.json { render json: @location_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /location_policies/1
  # PATCH/PUT /location_policies/1.json
  def update
    authorize! :update, @location_policy
    respond_to do |format|
      if @location_policy.update(location_policy_params)
        format.html { redirect_to @location_policy, notice: 'location_policy was successfully updated.' }
        format.json { render :show, status: :ok, location: @location_policy }
      else
        format.html { render :edit }
        format.json { render json: @location_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /location_policies/1
  # DELETE /location_policies/1.json
  def destroy
    authorize! :destroy, @location_policy
    @location_policy.destroy
    respond_to do |format|
      format.html { redirect_to location_policies_url, notice: 'location_policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location_policy
      @location_policy = LocationPolicy.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def location_policy_params
      params.require(:location_policy).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@location_policy.id}\nname: #{@location_policy.name}\ndescription: #{@location_policy.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @location_policy.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end

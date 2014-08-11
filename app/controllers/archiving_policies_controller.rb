class ArchivingPoliciesController < ApplicationController
  before_action :set_archiving_policy, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "policies_layout"

  # GET /archiving_policies %>
  # GET /archiving_policies.json
  def index
    #@archiving_policies = ArchivingPolicy.all
    @archiving_policies = ArchivingPolicy.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /archiving_policies/1
  # GET /archiving_policies/1.json
  def show
  end
  
  # GET /archiving_policies/new
  def new
    @archiving_policy = ArchivingPolicy.new
    authorize! :new, @archiving_policy
  end
  
  # GET /archiving_policies/1/edit
  def edit
    authorize! :edit, @archiving_policy
  end
  
  # POST /archiving_policies
  # POST /archiving_policies.json
  def create
    @archiving_policy = ArchivingPolicy.new(archiving_policy_params)
    authorize! :create, @archiving_policy

    respond_to do |format|
      if @archiving_policy.save
        format.html { redirect_to @archiving_policy, notice: 'archiving_policy was successfully created.' }
        format.json { render :show, status: :created, location: @archiving_policy }
      else
        format.html { render :new }
        format.json { render json: @archiving_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /archiving_policies/1
  # PATCH/PUT /archiving_policies/1.json
  def update
    authorize! :update, @archiving_policy
    respond_to do |format|
      if @archiving_policy.update(archiving_policy_params)
        format.html { redirect_to @archiving_policy, notice: 'archiving_policy was successfully updated.' }
        format.json { render :show, status: :ok, location: @archiving_policy }
      else
        format.html { render :edit }
        format.json { render json: @archiving_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /archiving_policies/1
  # DELETE /archiving_policies/1.json
  def destroy
    authorize! :destroy, @archiving_policy
    @archiving_policy.destroy
    respond_to do |format|
      format.html { redirect_to archiving_policies_url, notice: 'archiving_policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_archiving_policy
      @archiving_policy = ArchivingPolicy.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def archiving_policy_params
      params.require(:archiving_policy).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@archiving_policy.id}\nname: #{@archiving_policy.name}\ndescription: #{@archiving_policy.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @archiving_policy.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end

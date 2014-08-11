class ConferencePoliciesController < ApplicationController
  before_action :set_conference_policy, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "policies_layout"

  # GET /conference_policies %>
  # GET /conference_policies.json
  def index
    #@conference_policies = ConferencePolicy.all
    @conference_policies = ConferencePolicy.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /conference_policies/1
  # GET /conference_policies/1.json
  def show
  end
  
  # GET /conference_policies/new
  def new
    @conference_policy = ConferencePolicy.new
    authorize! :new, @conference_policy
  end
  
  # GET /conference_policies/1/edit
  def edit
    authorize! :edit, @conference_policy
  end
  
  # POST /conference_policies
  # POST /conference_policies.json
  def create
    @conference_policy = ConferencePolicy.new(conference_policy_params)
    authorize! :create, @conference_policy

    respond_to do |format|
      if @conference_policy.save
        format.html { redirect_to @conference_policy, notice: 'conference_policy was successfully created.' }
        format.json { render :show, status: :created, location: @conference_policy }
      else
        format.html { render :new }
        format.json { render json: @conference_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conference_policies/1
  # PATCH/PUT /conference_policies/1.json
  def update
    authorize! :update, @conference_policy
    respond_to do |format|
      if @conference_policy.update(conference_policy_params)
        format.html { redirect_to @conference_policy, notice: 'conference_policy was successfully updated.' }
        format.json { render :show, status: :ok, location: @conference_policy }
      else
        format.html { render :edit }
        format.json { render json: @conference_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conference_policies/1
  # DELETE /conference_policies/1.json
  def destroy
    authorize! :destroy, @conference_policy
    @conference_policy.destroy
    respond_to do |format|
      format.html { redirect_to conference_policies_url, notice: 'conference_policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conference_policy
      @conference_policy = ConferencePolicy.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def conference_policy_params
      params.require(:conference_policy).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@conference_policy.id}\nname: #{@conference_policy.name}\ndescription: #{@conference_policy.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @conference_policy.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end

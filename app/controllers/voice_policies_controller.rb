class VoicePoliciesController < ApplicationController
  before_action :set_voice_policy, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "policies_layout"

  # GET /voice_policies %>
  # GET /voice_policies.json
  def index
    #@voice_policies = VoicePolicy.all
    @voice_policies = VoicePolicy.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /voice_policies/1
  # GET /voice_policies/1.json
  def show
  end
  
  # GET /voice_policies/new
  def new
    @voice_policy = VoicePolicy.new
    authorize! :new, @voice_policy
  end
  
  # GET /voice_policies/1/edit
  def edit
    authorize! :edit, @voice_policy
  end
  
  # POST /voice_policies
  # POST /voice_policies.json
  def create
    @voice_policy = VoicePolicy.new(voice_policy_params)
    authorize! :create, @voice_policy

    respond_to do |format|
      if @voice_policy.save
        format.html { redirect_to @voice_policy, notice: 'voice_policy was successfully created.' }
        format.json { render :show, status: :created, location: @voice_policy }
      else
        format.html { render :new }
        format.json { render json: @voice_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /voice_policies/1
  # PATCH/PUT /voice_policies/1.json
  def update
    authorize! :update, @voice_policy
    respond_to do |format|
      if @voice_policy.update(voice_policy_params)
        format.html { redirect_to @voice_policy, notice: 'voice_policy was successfully updated.' }
        format.json { render :show, status: :ok, location: @voice_policy }
      else
        format.html { render :edit }
        format.json { render json: @voice_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /voice_policies/1
  # DELETE /voice_policies/1.json
  def destroy
    authorize! :destroy, @voice_policy
    @voice_policy.destroy
    respond_to do |format|
      format.html { redirect_to voice_policies_url, notice: 'voice_policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voice_policy
      @voice_policy = VoicePolicy.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def voice_policy_params
      params.require(:voice_policy).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@voice_policy.id}\nname: #{@voice_policy.name}\ndescription: #{@voice_policy.description}" 
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @voice_policy.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end

class ClientVersionPoliciesController < ApplicationController
  before_action :set_client_version_policy, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "policies_layout"

  # GET /client_version_policies %>
  # GET /client_version_policies.json
  def index
    #@client_version_policies = ClientVersionPolicy.all
    @client_version_policies = ClientVersionPolicy.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /client_version_policies/1
  # GET /client_version_policies/1.json
  def show
  end
  
  # GET /client_version_policies/new
  def new
    @client_version_policy = ClientVersionPolicy.new
    authorize! :new, @client_version_policy
  end
  
  # GET /client_version_policies/1/edit
  def edit
    authorize! :edit, @client_version_policy
  end
  
  # POST /client_version_policies
  # POST /client_version_policies.json
  def create
    @client_version_policy = ClientVersionPolicy.new(client_version_policy_params)
    authorize! :create, @client_version_policy

    respond_to do |format|
      if @client_version_policy.save
        format.html { redirect_to @client_version_policy, notice: 'client_version_policy was successfully created.' }
        format.json { render :show, status: :created, location: @client_version_policy }
      else
        format.html { render :new }
        format.json { render json: @client_version_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_version_policies/1
  # PATCH/PUT /client_version_policies/1.json
  def update
    authorize! :update, @client_version_policy
    respond_to do |format|
      if @client_version_policy.update(client_version_policy_params)
        format.html { redirect_to @client_version_policy, notice: 'client_version_policy was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_version_policy }
      else
        format.html { render :edit }
        format.json { render json: @client_version_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_version_policies/1
  # DELETE /client_version_policies/1.json
  def destroy
    authorize! :destroy, @client_version_policy
    @client_version_policy.destroy
    respond_to do |format|
      format.html { redirect_to client_version_policies_url, notice: 'client_version_policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_version_policy
      @client_version_policy = ClientVersionPolicy.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def client_version_policy_params
      params.require(:client_version_policy).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@client_version_policy.id}\nname: #{@client_version_policy.name}\ndescription: #{@client_version_policy.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @client_version_policy.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end

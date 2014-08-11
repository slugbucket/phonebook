class ClientPoliciesController < ApplicationController
  before_action :set_client_policy, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "policies_layout"

  # GET /client_policies %>
  # GET /client_policies.json
  def index
    #@client_policies = ClientPolicy.all
    @client_policies = ClientPolicy.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /client_policies/1
  # GET /client_policies/1.json
  def show
  end
  
  # GET /client_policies/new
  def new
    @client_policy = ClientPolicy.new
    authorize! :new, @client_policy
  end
  
  # GET /client_policies/1/edit
  def edit
    authorize! :edit, @client_policy
  end
  
  # POST /client_policies
  # POST /client_policies.json
  def create
    @client_policy = ClientPolicy.new(client_policy_params)
    authorize! :create, @client_policy

    respond_to do |format|
      if @client_policy.save
        format.html { redirect_to @client_policy, notice: 'client_policy was successfully created.' }
        format.json { render :show, status: :created, location: @client_policy }
      else
        format.html { render :new }
        format.json { render json: @client_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_policies/1
  # PATCH/PUT /client_policies/1.json
  def update
    authorize! :update, @client_policy
    respond_to do |format|
      if @client_policy.update(client_policy_params)
        format.html { redirect_to @client_policy, notice: 'client_policy was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_policy }
      else
        format.html { render :edit }
        format.json { render json: @client_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_policies/1
  # DELETE /client_policies/1.json
  def destroy
    authorize! :destroy, @client_policy
    @client_policy.destroy
    respond_to do |format|
      format.html { redirect_to client_policies_url, notice: 'client_policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_policy
      @client_policy = ClientPolicy.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def client_policy_params
      params.require(:client_policy).permit(:name, :description, :policy_type_id, :lync_policy_name)
    end
    def log_update
      log_msg = "id: #{@client_policy.id}\nname: #{@client_policy.name}\ndescription: #{@client_policy.description}\nlync_policy_name: #{@client_policy.lync_policy_name}" 
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @client_policy.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end

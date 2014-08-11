class PersistChatPoliciesController < ApplicationController
  before_action :set_persist_chat_policy, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "policies_layout"

  # GET /persist_chat_policies %>
  # GET /persist_chat_policies.json
  def index
    #@persist_chat_policies = PersistChatPolicy.all
    @persist_chat_policies = PersistChatPolicy.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /persist_chat_policies/1
  # GET /persist_chat_policies/1.json
  def show
  end
  
  # GET /persist_chat_policies/new
  def new
    @persist_chat_policy = PersistChatPolicy.new
    authorize! :new, @persist_chat_policy
  end
  
  # GET /persist_chat_policies/1/edit
  def edit
    authorize! :edit, @persist_chat_policy
  end
  
  # POST /persist_chat_policies
  # POST /persist_chat_policies.json
  def create
    @persist_chat_policy = PersistChatPolicy.new(persist_chat_policy_params)
    authorize! :create, @persist_chat_policy

    respond_to do |format|
      if @persist_chat_policy.save
        format.html { redirect_to @persist_chat_policy, notice: 'persist_chat_policy was successfully created.' }
        format.json { render :show, status: :created, location: @persist_chat_policy }
      else
        format.html { render :new }
        format.json { render json: @persist_chat_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /persist_chat_policies/1
  # PATCH/PUT /persist_chat_policies/1.json
  def update
    authorize! :update, @persist_chat_policy
    respond_to do |format|
      if @persist_chat_policy.update(persist_chat_policy_params)
        format.html { redirect_to @persist_chat_policy, notice: 'persist_chat_policy was successfully updated.' }
        format.json { render :show, status: :ok, location: @persist_chat_policy }
      else
        format.html { render :edit }
        format.json { render json: @persist_chat_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /persist_chat_policies/1
  # DELETE /persist_chat_policies/1.json
  def destroy
    authorize! :destroy, @persist_chat_policy
    @persist_chat_policy.destroy
    respond_to do |format|
      format.html { redirect_to persist_chat_policies_url, notice: 'persist_chat_policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_persist_chat_policy
      @persist_chat_policy = PersistChatPolicy.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def persist_chat_policy_params
      params.require(:persist_chat_policy).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@persist_chat_policy.id}\nname: #{@persist_chat_policy.name}\ndescription: #{@persist_chat_policy.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @persist_chat_policy.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end

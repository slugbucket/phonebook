class PinPoliciesController < ApplicationController
  before_action :set_pin_policy, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "policies_layout"

  # GET /pin_policies %>
  # GET /pin_policies.json
  def index
    #@pin_policies = PinPolicy.all
    @pin_policies = PinPolicy.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /pin_policies/1
  # GET /pin_policies/1.json
  def show
  end
  
  # GET /pin_policies/new
  def new
    @pin_policy = PinPolicy.new
    authorize! :new, @pin_policy
  end
  
  # GET /pin_policies/1/edit
  def edit
    authorize! :edit, @pin_policy
  end
  
  # POST /pin_policies
  # POST /pin_policies.json
  def create
    @pin_policy = PinPolicy.new(pin_policy_params)
    authorize! :create, @pin_policy

    respond_to do |format|
      if @pin_policy.save
        format.html { redirect_to @pin_policy, notice: 'pin_policy was successfully created.' }
        format.json { render :show, status: :created, location: @pin_policy }
      else
        format.html { render :new }
        format.json { render json: @pin_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pin_policies/1
  # PATCH/PUT /pin_policies/1.json
  def update
    authorize! :update, @pin_policy
    respond_to do |format|
      if @pin_policy.update(pin_policy_params)
        format.html { redirect_to @pin_policy, notice: 'pin_policy was successfully updated.' }
        format.json { render :show, status: :ok, location: @pin_policy }
      else
        format.html { render :edit }
        format.json { render json: @pin_policy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pin_policies/1
  # DELETE /pin_policies/1.json
  def destroy
    authorize! :destroy, @pin_policy
    @pin_policy.destroy
    respond_to do |format|
      format.html { redirect_to pin_policies_url, notice: 'pin_policy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin_policy
      @pin_policy = PinPolicy.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_policy_params
      params.require(:pin_policy).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@pin_policy.id}\nname: #{@pin_policy.name}\ndescription: #{@pin_policy.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @pin_policy.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end

class SubDepartmentsController < ApplicationController
  before_action :set_sub_department, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]
  load_and_authorize_resource :only => [:edit, :update]

  # GET /sub_departments
  # GET /sub_departments.json
  def index
    #@sub_departments = SubDepartment.all
    @sub_departments = SubDepartment.order("department_id, name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /sub_departments/1
  # GET /sub_departments/1.json
  def show
  end

  # GET /sub_departments/new
  def new
    @sub_department = SubDepartment.new
  end

  # GET /sub_departments/1/edit
  def edit
  end

  # POST /sub_departments
  # POST /sub_departments.json
  def create
    @sub_department = SubDepartment.new(sub_department_params)

    respond_to do |format|
      if @sub_department.save
        format.html { redirect_to @sub_department, notice: 'Sub department was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sub_department }
      else
        format.html { render action: 'new' }
        format.json { render json: @sub_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_departments/1
  # PATCH/PUT /sub_departments/1.json
  def update
    respond_to do |format|
      # Capture the Phone records that are affected by at least one policy update
      # and substitute in the submitted sub-departmental policy id
      # If SubDepartment.pin_policy_id = 2 and a update has been submitted that
      # changes the value to 3, then all Phone ercords in teh sub-department with
      # pin_policy_id = 2 need to have the pin_policy_id changed to 3.   
      ppt = Phone.policy_type_affectees(@sub_department.id, sub_department_params)
      if @sub_department.update(sub_department_params)
        get_policy_names
        # Get an array of the policy names so that the method to add an entry  
        ppt.each do |phone|
          Phone.update(phone.id, phone.to_hash)
          log_phone_update(phone.to_hash)
        end
        format.html { redirect_to @sub_department, notice: 'Sub department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sub_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_departments/1
  # DELETE /sub_departments/1.json
  def destroy
    @sub_department.destroy
    respond_to do |format|
      format.html { redirect_to sub_departments_url }
      format.json { head :no_content }
    end
  end

  # Custom action to return the default dialling right for the department used
  # to dynically update the phones dialling after selecting the sub-department
  # GET /sub_departments/1/default_dialling_right
  # GET /sub_departments/1/default_dialling_right.json
  def default_policies
    @default_policies = SubDepartment.select(:archiving_policy_id, :client_policy_id, :client_version_policy_id, :conferencing_policy_id, :dial_plan_policy_id, :external_access_policy_id, :location_policy_id, :mobility_policy_id, :persist_chat_policy_id, :pin_policy_id, :voice_policy_id).where(sub_departments: {id: params[:id]})

    respond_to do |format|
      format.html
      format.json { render json: @default_policies } 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_department
      @sub_department = SubDepartment.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_department_params
      params.require(:sub_department).permit(:name, :department_id, :sub_department_code, :preferred_extension_range_id, :archiving_policy_id, :client_policy_id, :client_version_policy_id, :conferencing_policy_id, :dial_plan_policy_id, :external_access_policy_id, :location_policy_id, :mobility_policy_id, :persist_chat_policy_id, :pin_policy_id, :voice_policy_id)
    end
    def get_policy_names
      @policy_names = {
        :archiving       => ArchivingPolicy.policy_name(@sub_department.archiving_policy_id),
        :client          => ClientPolicy.policy_name(@sub_department.client_policy_id),
        :client_version  => ClientVersionPolicy.policy_name(@sub_department.client_version_policy_id),
        :conferencing    => ConferencePolicy.policy_name(@sub_department.conferencing_policy_id),
        :dial_plan       => DialPlanPolicy.policy_name(@sub_department.dial_plan_policy_id),
        :external_access => ExternalAccessPolicy.policy_name(@sub_department.external_access_policy_id),
        :location        => LocationPolicy.policy_name(@sub_department.location_policy_id),
        :mobility        => MobilityPolicy.policy_name(@sub_department.mobility_policy_id),
        :persist_chat    => PersistChatPolicy.policy_name(@sub_department.persist_chat_policy_id),
        :pin             => PinPolicy.policy_name(@sub_department.pin_policy_id),
        :voice           => VoicePolicy.policy_name(@sub_department.voice_policy_id)
      }
    end
  def log_update
    dept = Department.dept_name(@sub_department.department_id)
    #ap  = ArchivingPolicy.find(@sub_department.archiving_policy_id).name
    ap = @policy_names[:archiving]
    clp = @policy_names[:client]
    cvp = @policy_names[:client_version]
    cp  = @policy_names[:conferencing]
    dpp = @policy_names[:dial_plan]
    eap = @policy_names[:external_access]
    lp  = @policy_names[:location]
    mp  = @policy_names[:mobility]
    pcp = @policy_names[:persist_chat]
    pp  = @policy_names[:pin]
    vp  = @policy_names[:voice]
    log_msg = "SubDepartment #{@sub_department.name} (#{@sub_department.id}) in #{dept}\nsub_department_code: #{@sub_department.sub_department_code}\narchiving_policy: #{ap}\nclient_policy: #{clp}\nclient_version_policy: #{cvp}\nconferencing_policy: #{cp}\ndial_plan_policy: #{dpp}\nexternal_access_policy: #{eap}\nlocation_policy: #{lp}\nmobility_policy: #{mp}\npersist_chat_policy: #{pcp}\npin_policy: #{pp}\nvoice_policy: #{vp}"
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @sub_department.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
  end
  # Log updates to phone records as part of the sub-department policy update 
  def log_phone_update(phone)
    ext = Extension.ext_number(phone["extension_id"])
    rm  = Room.room_name(phone["room_id"]) 
    ap  = phone[:archiving]
    clp = @policy_names[:client]
    cvp = @policy_names[:client_version]
    cp  = @policy_names[:conferencing]
    dpp = @policy_names[:dial_plan]
    eap = @policy_names[:external_access]
    lp  = @policy_names[:location]
    mp  = @policy_names[:mobility]
    pcp = @policy_names[:persist_chat]
    pp  = @policy_names[:pin]
    vp  = @policy_names[:voice]
    log_msg = "Phone: #{phone["firstname"]} #{phone["surname"]}\nuid: #{phone["uid"]}\nsub-department: #{@sub_department.name}\nExtension: #{ext}\nRoom: #{rm}\narchiving_policy: #{ap}\nclient_policy: #{clp}\nclient_version_policy: #{cvp}\nconferencing_policy: #{cp}\ndial_plan_policy: #{dpp}\nexternal_access_policy: #{eap}\nlocation_policy: #{lp}\nmobility_policy: #{mp}\npersist_chat_policy: #{pcp}\npin_policy: #{pp}\nvoice_policy: #{vp}"
    ActivityLog.create(:item_type => "Phone", :item_id => phone["id"], :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
  end
end

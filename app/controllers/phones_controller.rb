class PhonesController < ApplicationController
  before_action :set_phone, only: [:show, :edit, :update, :destroy]
  before_action :set_initials, only: [:index, :search]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:update]
  #helper_method :sort_column, :sort_direction

  # GET /phones
  # GET /phones.json
  def index
    search_term = (session[:search].nil?) ? "?" : session[:search] 
    if session[:phone_subdept] then
      @phones = Phone.phones_in_subdept(session[:phone_subdept]).order("phones.surname"+" "+sort_direction).paginate :page => session[:phone_page], :per_page => 25
    elsif session[:search] then
      @phones = Phone.find_by_extension(session[:search]).order(:surname).paginate :page => session[:phone_page], :per_page => 25
      if @phones.empty? then
        @phones = Phone.find_by_location(session[:search]).order(:surname).paginate :page => session[:phone_page], :per_page => 25
      end
      if @phones.empty? then
        @phones = Phone.where(" surname LIKE ? OR uid LIKE ?", "%"+session[:search]+"%", "%"+session[:search]+"%").paginate :page => session[:phone_page], :per_page => 25
      end  
    else # Default search method
      @phones = Phone.order(:surname).paginate :page => session[:phone_page], :per_page => 25
    end
  end

  # GET /phones/1
  # GET /phones/1.json
  def show

  end

  # GET /phones/new
  def new
    @phone = Phone.new
    authorize! :edit, @phone
  end

  # GET /phones/1/edit
  def edit
    @ext = Extension.where(:id => @phone.extension_id)
  end

  # GET /phones/1/free_extensions
  # GET /phones/1/free_extensions.json
  def free_extensions
    sdept = params[:id]
    @extensions = Extension.sub_dept_next(sdept)

    respond_to do |format|
      format.html
      format.json { render json: @extensions } 
    end
  end

  # POST /phones
  # POST /phones.json
  def create
    @phone = Phone.new(phone_params)
    authorize! :create, @phone

    respond_to do |format|
      if @phone.save
        format.html { redirect_to @phone, notice: 'Phone was successfully created.' }
        format.json { render action: 'show', status: :created, location: @phone }
      else
        format.html { render action: 'new' }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phones/1
  # PATCH/PUT /phones/1.json
  def update
    authorize! :update, @phone
    
    respond_to do |format|
      if @phone.update(phone_params)
        format.html { redirect_to @phone, notice: 'Phone was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phones/1
  # DELETE /phones/1.json
  def destroy
    authorize! :destroy, @phone
    @phone.destroy
    respond_to do |format|
      format.html { redirect_to phones_url }
      format.json { head :no_content }
    end
  end

  # GET /phones/search
  def search
    sc = (session[:search].nil?) ? "" : session[:search]
    search_condition = "%" + sc + "%"
    #@tempaccts = Tempacct.paginate :page => params[:page], :order => 'uid asc', :per_page => 25, :conditions => ['uid LIKE ? OR description LIKE ? OR name LIKE ? OR name LIKE ?', search_condition, search_condition, search_condition, search_condition]
    @phones = Phone.where('uid LIKE ? OR firstname LIKE ? OR surname LIKE ? OR surname LIKE ?', search_condition, search_condition, search_condition, search_condition).order("surname asc").paginate :page => params[:page], :per_page => 25

    respond_to do |format|
      format.html { redirect_to phones_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phone
      @phone = Phone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_params
      params.require(:phone).permit(:sub_department_id, :extension_id, :room_id, :archiving_policy_id, :client_policy_id, :client_version_policy_id, :conferencing_policy_id, :dial_plan_policy_id, :external_access_policy_id, :location_policy_id, :mobility_policy_id, :persist_chat_policy_id, :pin_policy_id, :voice_policy_id)
    end
  def set_initials
    #@first_letters = Phone.select("DISTINCT LOWER(SUBSTRING(phones.surname, 1, 1)) AS surname").order("surname").collect{|fl| "#{fl.surname}"}
    session.delete :phone_page if params[:page]
    session[:phone_page] ||= params[:page]
    if session[:phone_letter] != params[:q] && params[:q] then
      session[:phone_page] = 1
    end
    # Check for when a subdept selection request comes in
    # This is ugly and clashes with the 
    if params[:subdept] then
      session.delete :search
      session.delete :phone_page if session[:phone_subdept] != params[:subdept].to_i
      session.delete :phone_sortcol
      session.delete :phone_subdept
    end
    #session[:phone_subdept] ||= (params[:subdept].to_i > 0) ? params[:subdept].to_i : nil 
    session[:phone_subdept] ||= params[:subdept].to_i if params[:subdept].to_i > 0

    # Running a search clears the current session data
    if params[:findbyname] then
      session.delete :phone_page
      session.delete :phone_sortcol
      session.delete :phone_subdept
      session.delete :phone_letter
      session.delete :search
      session[:search] ||= params[:findbyname]
    end
    # An additional check for clearing the search term
    session.delete :search if session[:search].nil? || session[:search].empty?
    session[:phone_page] ||= (params[:page] && params[:page].to_i.is_a?(Integer)) ? params[:page].to_i : 1
    #session.delete :phone_letter if params[:q]
    #session[:phone_letter] ||= ('a'..'z').include?(params[:q]) ? params[:q] : ''
    session.delete :phone_letter if params[:q]
    session[:phone_letter] ||= ('a'..'z').include?(params[:q]) ? params[:q] : ''
    session.delete :phone_sortcol if params[:sort]
    session[:phone_sortcol] ||= sort_column
  end

  def sort_column
    %w[subdept extno].include?(params[:sort]) ? params[:sort] : "surname"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
  def log_update
    ext = Extension.ext_number(@phone.extension_id)
    rm  = Room.room_name(@phone.room_id)
    sdp = SubDepartment.subdept_name(@phone.sub_department_id)
    ap  = ArchivingPolicy.find(@phone.archiving_policy_id).name
    clp = ClientPolicy.find(@phone.client_policy_id).name
    cvp = ClientVersionPolicy.find(@phone.client_version_policy_id).name
    cp  = ConferencePolicy.find(@phone.conferencing_policy_id).name
    dpp = DialPlanPolicy.find(@phone.dial_plan_policy_id).name
    eap = ExternalAccessPolicy.find(@phone.external_access_policy_id).name
    lp  = LocationPolicy.find(@phone.location_policy_id).name
    mp  = MobilityPolicy.find(@phone.mobility_policy_id).name
    pcp = PersistChatPolicy.find(@phone.persist_chat_policy_id).name
    pp  = PinPolicy.find(@phone.pin_policy_id).name
    vp  = VoicePolicy.find(@phone.voice_policy_id).name
    log_msg = "id: #{@phone.id}\n#{@phone.user_name}\nsub_department: #{sdp}\nextension: #{ext}\narchiving_policy: #{ap}\nclient_policy: #{clp}\nclient_version_policy: #{cvp}\nconference_policy: #{cp}\ndial_plan_policy: #{dpp}\nexternal_access_policy: #{eap}\nlocation_policy: #{lp}\nmobility_policy: #{mp}\npersist_chat_policy: #{pcp}\npin_policy: #{pp}\nvoice_policy: #{vp}" 
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @phone.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    #Rails.logger.debug "DEBUG: #{current_user.username} Updated data: ext #{ext} in subdept #{sdp} for #{@phone.user_name}"
  end
end

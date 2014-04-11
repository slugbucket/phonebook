class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  before_action :set_session, only: :index
  helper_method :sort_column, :sort_direction
  after_action :log_update, only: [:create, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @all_rooms = Room.where("room_status_id = 1 AND public_name like ?", "%#{params[:q]}%")
    if session[:bldng] then
      Rails.logger.debug("DEBUG: Searching by building: #{session[:bldng]}.")
      @rooms = Room.where(:building_id => session[:bldng]).order(:room_status_id, :public_name).paginate :page => session[:room_page], :per_page => 25
    elsif session[:findbyloc] && ! session[:findbyloc].nil? then
      Rails.logger.debug("DEBUG: Searching by room name #{session[:findbyloc]}.")
      @rooms = Room.where("rooms.name LIKE ? OR rooms.public_name LIKE ?", "%"+session[:findbyloc]+"%", "%"+session[:findbyloc]+"%").order(:room_status_id, :public_name).paginate :page => session[:room_page], :per_page => 25
    else
      @rooms = Room.order(:room_status_id, :public_name).paginate :page => session[:room_page], :per_page => 25
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hosts }
      format.json  { render :json => @all_rooms.map{|r| {:id => r.id, :name => r.public_name}}}
    end
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
    authorize! :new, @room
  end

  # GET /rooms/1/edit
  def edit
    authorize! :edit, @room
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    authorize! :create, @room

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render action: 'show', status: :created, location: @room }
      else
        format.html { render action: 'new' }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    authorize! :update, @room
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    authorize! :destroy, @room
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Set session values for things such as searching, pagination, etx 
    def set_session
      if params[:findbyloc] then
        session.delete :bldng
        session.delete :findbyloc
        session.delete :room_page if session[:findbyloc] != params[:findbyloc]
      end
      if params[:building] then
        session.delete :bldng
        session.delete :findbyloc
        session.delete :room_page if session[:bldng] != params[:building]
      end
      session[:findbyloc] ||= params[:findbyloc]# if params[:findbyloc]
      
      if params[:page] then
        session.delete :room_page
        session[:room_page] ||= (params[:page].to_i.is_a?(Integer)) ? params[:page].to_i : 1
      end
      session[:bldng] ||= params[:building].to_i if params[:building].to_i > 0
    end
    def sort_column
      Room.column_names.include?(params[:sort]) ? params[:sort] : "room_statuses.name"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:name, :public_name, :room_status_id, :building_id, :building_floor_id)
  end
  def log_update
    rs = RoomStatus.room_status_name(@room.room_status_id)
    b = Building.building_name(@room.building_id)
    bf = BuildingFloor.building_floor_name(@room.building_floor_id)
    log_msg = "id: #{@room.id}\nname: #{@room.name}\npublic_name: #{@room.public_name}\nbuilding: #{b}\nbuilding_floor: #{bf}\nroom_status: #{rs}" 
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @room.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
  end
end

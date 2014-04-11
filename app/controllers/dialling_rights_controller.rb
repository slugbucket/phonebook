class DiallingRightsController < ApplicationController
  before_action :set_dialling_right, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  # GET /dialling_rights
  # GET /dialling_rights.json
  def index
    @dialling_rights = DiallingRight.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /dialling_rights/1
  # GET /dialling_rights/1.json
  def show
  end

  # GET /dialling_rights/new
  def new
    @dialling_right = DiallingRight.new
    authorize! :new, @dialling_right
  end

  # GET /dialling_rights/1/edit
  def edit
    authorize! :new, @dialling_right
  end

  # POST /dialling_rights
  # POST /dialling_rights.json
  def create
    @dialling_right = DiallingRight.new(dialling_right_params)
    authorize! :create, @dialling_right

    respond_to do |format|
      if @dialling_right.save
        format.html { redirect_to @dialling_right, notice: 'Dailling right was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dialling_right }
      else
        format.html { render action: 'new' }
        format.json { render json: @dialling_right.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dialling_rights/1
  # PATCH/PUT /dialling_rights/1.json
  def update
    authorize! :update, @dialling_right
    respond_to do |format|
      if @dialling_right.update(dialling_right_params)
        format.html { redirect_to @dialling_right, notice: 'Dailling right was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dialling_right.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dialling_rights/1
  # DELETE /dialling_rights/1.json
  def destroy
    authorize! :destroy, @dialling_right
    @dialling_right.destroy
    respond_to do |format|
      format.html { redirect_to dialling_rights_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dialling_right
      @dialling_right = DiallingRight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dialling_right_params
      params.require(:dialling_right).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@dialling_right.id}\nname: #{@dialling_right.name}\ndescription: #{@dialling_right.description}"
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @dialling_right.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end
end


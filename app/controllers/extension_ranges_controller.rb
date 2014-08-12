class ExtensionRangesController < ApplicationController
  before_action :set_extension_range, only: [:show, :edit, :update, :destroy]
  after_action :create_extensions, only: [:create]
  after_action :delete_extensions, only: [:destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  # GET /extension_ranges
  # GET /extension_ranges.json
  def index
    #@extension_ranges = ExtensionRange.all
    @extension_ranges = ExtensionRange.order("first_extension asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /extension_ranges/1
  # GET /extension_ranges/1.json
  def show
  end

  # GET /extension_ranges/new
  def new
    @extension_range = ExtensionRange.new
    authorize! :create, @extension_range
  end

  # GET /extension_ranges/1/edit
  def edit
    authorize! :edit, @extension_range
  end

  # POST /extension_ranges
  # POST /extension_ranges.json
  def create
    @extension_range = ExtensionRange.new(extension_range_params)
    authorize! :create, @extension_range

    respond_to do |format|
      if @extension_range.save
        format.html { redirect_to @extension_range, notice: 'Extension range was successfully created.' }
        format.json { render action: 'show', status: :created, location: @extension_range }
      else
        format.html { render action: 'new' }
        format.json { render json: @extension_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extension_ranges/1
  # PATCH/PUT /extension_ranges/1.json
  def update
    authorize! :update, @extension_range
    respond_to do |format|
      if @extension_range.update(extension_range_params)
        format.html { redirect_to @extension_range, notice: 'Extension range was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @extension_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extension_ranges/1
  # DELETE /extension_ranges/1.json
  def destroy
    authorize! :destroy, @extension_range
    @extension_range.destroy
    respond_to do |format|
      format.html { redirect_to extension_ranges_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extension_range
      @extension_range = ExtensionRange.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extension_range_params
      params.require(:extension_range).permit(:first_extension, :last_extension, :department_tokens)
  end
  # Method to populate the extensions list with records for the newly added range
  def create_extensions
    f = @extension_range.first_extension.to_i
    l = @extension_range.last_extension.to_i
    #(params[:first_extension]..params[:last_extension]).each {|e| notices.add(e)}
    while (f <= l)
      Extension.create(:extension => f.to_s, :created_at => Time.now().strftime("%Y-%m-%d %H:%M:%S"), :updated_at => Time.now().strftime("%Y-%m-%d %H:%M:%S"))
      f += 1
    end
  end
  # Method to delete all the extensions ina range when the range is deleted
  def delete_extensions
    f = @extension_range.first_extension.to_i
    l = @extension_range.last_extension.to_i
    Extension.active_extensions(f, l).pluck(:id).map {|e| Extension.destroy(e)}
  end
  def log_update
    if @extension_range.department_ids.empty? then
      dept = "none"
    else
      dept = Department.dept_name(@extension_range.department_ids[0])
    end
    log_msg = "id: #{@extension_range.id}\nfirst_extension: #{@extension_range.first_extension}\nlast_extension: #{@extension_range.last_extension}\nDepartment: #{dept}"
    #Rails.logger.debug "DEBUG: #{log_msg}"
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @extension_range.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
  end
end

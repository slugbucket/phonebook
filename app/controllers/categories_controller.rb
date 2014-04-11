class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    #@categories = Category.all
    @categories = Category.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
    authorize! :new, @category
  end

  # GET /categories/1/edit
  def edit
    authorize! :edit, @category
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    authorize! :create, @category

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    authorize! :update, @category
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    authorize! :destroy, @category
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
  end
  def log_update
    log_msg = "id: #{@category.id}\nname: #{@category.name}"
    Rails.logger.debug "DEBUG: #{log_msg}"
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @category.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
  end
end

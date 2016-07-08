class ListreviewsController < ApplicationController
  before_action :set_listreview, only: [:show, :edit, :update, :destroy]
  before_action :set_listing
  before_action :authenticate_user!
  before_action :check_listing, only: [:edit, :update, :destroy]


  # GET /listreviews
  # GET /listreviews.json
  def index
    @listreviews = Listreview.all
  end

  # GET /listreviews/1
  # GET /listreviews/1.json
  def show
    @listing = Listing.find(params[:listing_id])
    @listreviews = Listreview.where (@listing)
  end

  # GET /listreviews/new
  def new
    @listreview = Listreview.new
  end

  # GET /listreviews/1/edit
  def edit
  end

  # POST /listreviews
  # POST /listreviews.json
  def create
    @listreview = Listreview.new(listreview_params)
    @listreview.user_id = current_user.id
    @listreview.listing_id = @listing.id


    respond_to do |format|
      if @listreview.save
        format.html { redirect_to root_path, notice: 'Listreview was successfully created.' }
        format.json { render :show, status: :created, location: @listreview }
      else
        format.html { render :new }
        format.json { render json: @listreview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listreviews/1
  # PATCH/PUT /listreviews/1.json
  def update
    respond_to do |format|
      if @listreview.update(listreview_params)
        format.html { redirect_to @listreview, notice: 'Listreview was successfully updated.' }
        format.json { render :show, status: :ok, location: @listreview }
      else
        format.html { render :edit }
        format.json { render json: @listreview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listreviews/1
  # DELETE /listreviews/1.json
  def destroy
    @listreview.destroy
    respond_to do |format|
      format.html { redirect_to listreviews_url, notice: 'Listreview was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listreview
      @listreview = Listreview.find(params[:id])
    end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end


    # Never trust parameters from the scary internet, only allow the white list through.
    def listreview_params
      params.require(:listreview).permit(:rating, :comment)
    end
end
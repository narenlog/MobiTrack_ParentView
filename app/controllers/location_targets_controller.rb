class LocationTargetsController < ApplicationController
  before_action :set_location_target, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [] # for all pages
  before_action :admin_access, except: [] # for all pages

  # GET /location_targets
  # GET /location_targets.json
  def index
    @location_targets = LocationTarget.all
  end

  # GET /location_targets/1
  # GET /location_targets/1.json
  def show
  end

  # GET /location_targets/new
  def new
    @location_target = LocationTarget.new
  end

  # GET /location_targets/1/edit
  def edit
  end

  # POST /location_targets
  # POST /location_targets.json
  def create
    @location_target = LocationTarget.new(location_target_params)

    respond_to do |format|
      if @location_target.save
        format.html { redirect_to @location_target, notice: 'Location target was successfully created.' }
        format.json { render action: 'show', status: :created, location: @location_target }
      else
        format.html { render action: 'new' }
        format.json { render json: @location_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /location_targets/1
  # PATCH/PUT /location_targets/1.json
  def update
    respond_to do |format|
      if @location_target.update(location_target_params)
        format.html { redirect_to @location_target, notice: 'Location target was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /location_targets/1
  # DELETE /location_targets/1.json
  def destroy
    @location_target.destroy
    respond_to do |format|
      format.html { redirect_to location_targets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location_target
      @location_target = LocationTarget.find(params[:id])
    end

    def admin_access
      if (current_user.email != "write2krishna@gmail.com")
        redirect_to root_path, notice: "Not authorized" 
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_target_params
      params.require(:location_target).permit(:latitude, :longitude, :address, :description, :title)
    end
end

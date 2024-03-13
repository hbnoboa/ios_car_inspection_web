class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:create, :update]

  # GET /vehicles or /vehicles.json
  def index
    @query = params[:query]
    page = (params[:page] || 1).to_i
    per_page = 10 # Number of items per page
  
    if @query.present?
      # Perform a case-insensitive search across all fields of the Vehicle model
      @vehicles = Vehicle.any_of(
        { chassis: /#{@query}/i },
        { model: /#{@query}/i },
        { location: /#{@query}/i },
        { ship: /#{@query}/i },
        { situation: /#{@query}/i },
        { nonconformity: /#{@query}/i }
      )
    else
      # If no search query is provided, display all vehicles
      @vehicles = Vehicle.all
    end
  
    total_count = @vehicles.count
    total_pages = (total_count.to_f / per_page).ceil
  
    # Calculate the offset and limit for pagination
    offset = per_page * (page - 1)
    limit = per_page
  
    # Apply pagination
    @vehicles = @vehicles.limit(limit).skip(offset)
  
    @pagy = Pagy.new(count: total_count, page: page, items: per_page)
  end
  

  # GET /vehicles/1 or /vehicles/1.json
  def show
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # GET /vehicles/1/edit
  def edit
  end

  # POST /vehicles or /vehicles.json
  def create
    preprocess_image_params(params)
    @vehicle = Vehicle.new(vehicle_params)

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to vehicle_url(@vehicle), notice: "Vehicle was successfully created." }
        format.json { render :show, status: :created, location: @vehicle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1 or /vehicles/1.json
  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to vehicle_url(@vehicle), notice: "Vehicle was successfully updated." }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /vehicles/1 or /vehicles/1.json
  def destroy
    @vehicle.destroy!

    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: "Vehicle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def preprocess_image_params(params)
    [:etChassisImage, :profileImage, :frontImage, :backImage, :rightSideImage, :leftSideImage].each do |image_attr|
      if params[:vehicle][image_attr].present?
        file = params[:vehicle][image_attr].tempfile
        encoded_data = Base64.strict_encode64(file.read)
        params[:vehicle]["#{image_attr}"] = "data:#{params[:vehicle][image_attr].content_type};base64,#{encoded_data}"
      end
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vehicle_params
      params.require(:vehicle).permit(:location, :type, :chassis, :nonconformity, :model, :status, :ship, :situation, :observations, :etChassisImage, :profileImage, :frontImage, :backImage, :rightSideImage, :leftSideImage)
    end
    
end

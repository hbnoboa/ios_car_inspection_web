class Vehicles::NonconformitiesController < ApplicationController
  before_action :set_vehicle
  before_action :set_nonconformity, only: %i[ show edit update destroy ]

  # GET /nonconformities or /nonconformities.json
  def index
    @nonconformities = @vehicle.nonconformities
  end

  def all_nonconformities
    @nonconformities = Nonconformity.all.includes(:vehicle)
    render json: @nonconformities
  end

  # GET /nonconformities/1 or /nonconformities/1.json
  def show
  end

  # GET /nonconformities/new
  def new
    @nonconformity = @vehicle.nonconformities.build
  end

  # GET /nonconformities/1/edit
  def edit
  end

  # POST /nonconformities or /nonconformities.json
  def create
    @nonconformity = @vehicle.nonconformities.build(nonconformity_params)

    respond_to do |format|
      if @nonconformity.save
        format.html { redirect_to vehicle_url(@vehicle), notice: "Nonconformity was successfully created." }
        format.json { render :show, status: :created, location: @nonconformity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nonconformity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nonconformities/1 or /nonconformities/1.json
  def update
    respond_to do |format|
      if @nonconformity.update(nonconformity_params)
        format.html { redirect_to vehicle_url(@vehicle), notice: "Nonconformity was successfully updated." }
        format.json { render :show, status: :ok, location: @nonconformity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nonconformity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nonconformities/1 or /nonconformities/1.json
  def destroy
    @nonconformity.destroy

    respond_to do |format|
      format.html { redirect_to vehicle_nonconformities_url, notice: "Nonconformity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_vehicle
    if params[:vehicle_id].present?
      vehicle_id = params[:vehicle_id].is_a?(Hash) ? params[:vehicle_id]['$oid'] : params[:vehicle_id]
      puts 'começo'
      puts vehicle_id
      vehicle_hash = { '_id' => BSON::ObjectId.from_string(vehicle_id) }
      @vehicle = Vehicle.instantiate(vehicle_hash)
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_nonconformity
      @nonconformity = Nonconformity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nonconformity_params
      params.require(:nonconformity).permit(:vehicleParts, :nonconformityTypes, :nonconformityLevels, :quadrants, :measures, :nonconformityLocals, :vehicle_id, :image1, :image2, :image3, :image4, :vehicle_id)
    end
    
end
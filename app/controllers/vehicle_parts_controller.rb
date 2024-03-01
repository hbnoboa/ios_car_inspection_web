class VehiclePartsController < ApplicationController
  before_action :set_vehicle_part, only: %i[ show edit update destroy ]

  # GET /vehicle_parts or /vehicle_parts.json
  def index
    @vehicle_parts = VehiclePart.all
  end

  # GET /vehicle_parts/1 or /vehicle_parts/1.json
  def show
  end

  # GET /vehicle_parts/new
  def new
    @vehicle_part = VehiclePart.new
  end

  # GET /vehicle_parts/1/edit
  def edit
  end

  # POST /vehicle_parts or /vehicle_parts.json
  def create
    @vehicle_part = VehiclePart.new(vehicle_part_params)

    respond_to do |format|
      if @vehicle_part.save
        format.html { redirect_to vehicle_part_url(@vehicle_part), notice: "Vehicle part was successfully created." }
        format.json { render :show, status: :created, location: @vehicle_part }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vehicle_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicle_parts/1 or /vehicle_parts/1.json
  def update
    respond_to do |format|
      if @vehicle_part.update(vehicle_part_params)
        format.html { redirect_to vehicle_part_url(@vehicle_part), notice: "Vehicle part was successfully updated." }
        format.json { render :show, status: :ok, location: @vehicle_part }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vehicle_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicle_parts/1 or /vehicle_parts/1.json
  def destroy
    @vehicle_part.destroy!

    respond_to do |format|
      format.html { redirect_to vehicle_parts_url, notice: "Vehicle part was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_part
      @vehicle_part = VehiclePart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vehicle_part_params
      params.require(:vehicle_part).permit(:area, :name)
    end
end

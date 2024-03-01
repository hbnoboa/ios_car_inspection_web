class QuadrantsController < ApplicationController
  before_action :set_quadrant, only: %i[ show edit update destroy ]

  # GET /quadrants or /quadrants.json
  def index
    @quadrants = Quadrant.all
  end

  # GET /quadrants/1 or /quadrants/1.json
  def show
  end

  # GET /quadrants/new
  def new
    @quadrant = Quadrant.new
  end

  # GET /quadrants/1/edit
  def edit
  end

  # POST /quadrants or /quadrants.json
  def create
    @quadrant = Quadrant.new(quadrant_params)

    respond_to do |format|
      if @quadrant.save
        format.html { redirect_to quadrant_url(@quadrant), notice: "Quadrant was successfully created." }
        format.json { render :show, status: :created, location: @quadrant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quadrant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quadrants/1 or /quadrants/1.json
  def update
    respond_to do |format|
      if @quadrant.update(quadrant_params)
        format.html { redirect_to quadrant_url(@quadrant), notice: "Quadrant was successfully updated." }
        format.json { render :show, status: :ok, location: @quadrant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quadrant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quadrants/1 or /quadrants/1.json
  def destroy
    @quadrant.destroy!

    respond_to do |format|
      format.html { redirect_to quadrants_url, notice: "Quadrant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quadrant
      @quadrant = Quadrant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quadrant_params
      params.require(:quadrant).permit(:option)
    end
end

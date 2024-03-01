class MeasuresController < ApplicationController
  before_action :set_measure, only: %i[ show edit update destroy ]

  # GET /measures or /measures.json
  def index
    @measures = Measure.all
  end

  # GET /measures/1 or /measures/1.json
  def show
  end

  # GET /measures/new
  def new
    @measure = Measure.new
  end

  # GET /measures/1/edit
  def edit
  end

  # POST /measures or /measures.json
  def create
    @measure = Measure.new(measure_params)

    respond_to do |format|
      if @measure.save
        format.html { redirect_to measure_url(@measure), notice: "Measure was successfully created." }
        format.json { render :show, status: :created, location: @measure }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @measure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /measures/1 or /measures/1.json
  def update
    respond_to do |format|
      if @measure.update(measure_params)
        format.html { redirect_to measure_url(@measure), notice: "Measure was successfully updated." }
        format.json { render :show, status: :ok, location: @measure }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @measure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /measures/1 or /measures/1.json
  def destroy
    @measure.destroy!

    respond_to do |format|
      format.html { redirect_to measures_url, notice: "Measure was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_measure
      @measure = Measure.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def measure_params
      params.require(:measure).permit(:size)
    end
end

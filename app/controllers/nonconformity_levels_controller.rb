class NonconformityLevelsController < ApplicationController
  before_action :set_nonconformity_level, only: %i[ show edit update destroy ]

  # GET /nonconformity_levels or /nonconformity_levels.json
  def index
    @nonconformity_levels = NonconformityLevel.all
  end

  # GET /nonconformity_levels/1 or /nonconformity_levels/1.json
  def show
  end

  # GET /nonconformity_levels/new
  def new
    @nonconformity_level = NonconformityLevel.new
  end

  # GET /nonconformity_levels/1/edit
  def edit
  end

  # POST /nonconformity_levels or /nonconformity_levels.json
  def create
    @nonconformity_level = NonconformityLevel.new(nonconformity_level_params)

    respond_to do |format|
      if @nonconformity_level.save
        format.html { redirect_to nonconformity_level_url(@nonconformity_level), notice: "Nonconformity level was successfully created." }
        format.json { render :show, status: :created, location: @nonconformity_level }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nonconformity_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nonconformity_levels/1 or /nonconformity_levels/1.json
  def update
    respond_to do |format|
      if @nonconformity_level.update(nonconformity_level_params)
        format.html { redirect_to nonconformity_level_url(@nonconformity_level), notice: "Nonconformity level was successfully updated." }
        format.json { render :show, status: :ok, location: @nonconformity_level }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nonconformity_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nonconformity_levels/1 or /nonconformity_levels/1.json
  def destroy
    @nonconformity_level.destroy!

    respond_to do |format|
      format.html { redirect_to nonconformity_levels_url, notice: "Nonconformity level was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nonconformity_level
      @nonconformity_level = NonconformityLevel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nonconformity_level_params
      params.require(:nonconformity_level).permit(:level)
    end
end

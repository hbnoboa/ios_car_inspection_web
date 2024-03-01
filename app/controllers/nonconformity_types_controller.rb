class NonconformityTypesController < ApplicationController
  before_action :set_nonconformity_type, only: %i[ show edit update destroy ]

  # GET /nonconformity_types or /nonconformity_types.json
  def index
    @nonconformity_types = NonconformityType.all
  end

  # GET /nonconformity_types/1 or /nonconformity_types/1.json
  def show
  end

  # GET /nonconformity_types/new
  def new
    @nonconformity_type = NonconformityType.new
  end

  # GET /nonconformity_types/1/edit
  def edit
  end

  # POST /nonconformity_types or /nonconformity_types.json
  def create
    @nonconformity_type = NonconformityType.new(nonconformity_type_params)

    respond_to do |format|
      if @nonconformity_type.save
        format.html { redirect_to nonconformity_type_url(@nonconformity_type), notice: "Nonconformity type was successfully created." }
        format.json { render :show, status: :created, location: @nonconformity_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nonconformity_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nonconformity_types/1 or /nonconformity_types/1.json
  def update
    respond_to do |format|
      if @nonconformity_type.update(nonconformity_type_params)
        format.html { redirect_to nonconformity_type_url(@nonconformity_type), notice: "Nonconformity type was successfully updated." }
        format.json { render :show, status: :ok, location: @nonconformity_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nonconformity_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nonconformity_types/1 or /nonconformity_types/1.json
  def destroy
    @nonconformity_type.destroy!

    respond_to do |format|
      format.html { redirect_to nonconformity_types_url, notice: "Nonconformity type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nonconformity_type
      @nonconformity_type = NonconformityType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nonconformity_type_params
      params.require(:nonconformity_type).permit(:nctype)
    end
end

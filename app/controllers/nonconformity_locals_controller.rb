class NonconformityLocalsController < ApplicationController
  before_action :set_nonconformity_local, only: %i[ show edit update destroy ]

  # GET /nonconformity_locals or /nonconformity_locals.json
  def index
    @nonconformity_locals = NonconformityLocal.all
  end

  # GET /nonconformity_locals/1 or /nonconformity_locals/1.json
  def show
  end

  # GET /nonconformity_locals/new
  def new
    @nonconformity_local = NonconformityLocal.new
  end

  # GET /nonconformity_locals/1/edit
  def edit
  end

  # POST /nonconformity_locals or /nonconformity_locals.json
  def create
    @nonconformity_local = NonconformityLocal.new(nonconformity_local_params)

    respond_to do |format|
      if @nonconformity_local.save
        format.html { redirect_to nonconformity_local_url(@nonconformity_local), notice: "Nonconformity local was successfully created." }
        format.json { render :show, status: :created, location: @nonconformity_local }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nonconformity_local.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nonconformity_locals/1 or /nonconformity_locals/1.json
  def update
    respond_to do |format|
      if @nonconformity_local.update(nonconformity_local_params)
        format.html { redirect_to nonconformity_local_url(@nonconformity_local), notice: "Nonconformity local was successfully updated." }
        format.json { render :show, status: :ok, location: @nonconformity_local }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nonconformity_local.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nonconformity_locals/1 or /nonconformity_locals/1.json
  def destroy
    @nonconformity_local.destroy!

    respond_to do |format|
      format.html { redirect_to nonconformity_locals_url, notice: "Nonconformity local was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nonconformity_local
      @nonconformity_local = NonconformityLocal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nonconformity_local_params
      params.require(:nonconformity_local).permit(:local)
    end
end

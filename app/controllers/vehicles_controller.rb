class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[show edit update destroy show_pdf]
  skip_before_action :verify_authenticity_token, only: %i[create update]

  def index
    @query = params[:query]
    page = (params[:page] || 1).to_i
    per_page = 10

    if @query.present?
      @vehicles = Vehicle.any_of(
        { chassis: /#{@query}/i },
        { model: /#{@query}/i },
        { location: /#{@query}/i },
        { ship: /#{@query}/i },
        { situation: /#{@query}/i },
        { nonconformity: /#{@query}/i }
      ).where(done: 'yes')
    else
      @vehicles = Vehicle.all.where(done: 'yes')
    end

    total_count = @vehicles.count
    total_pages = (total_count.to_f / per_page).ceil

    offset = per_page * (page - 1)
    limit = per_page

    @vehicles = @vehicles.limit(limit).skip(offset)

    @pagy = Pagy.new(count: total_count, page: page, items: per_page)

  end

  def show
  end

  def show_pdf
    pdf = Prawn::Document.new(page_size: 'A4', :margin => [70,70,0,70])
  
      pdf.canvas do 
        pdf.bounding_box([pdf.bounds.left + 70 , pdf.bounds.top - 70, pdf.bounds.right, pdf.bounds.bottom], width: 455, height: 155) do
          pdf.image Rails.root.join('app', 'assets', 'images', 'nexus.jpg'), width: 170, at: [pdf.bounds.left, pdf.bounds.top]
          pdf.move_down 75
          pdf.bounding_box([pdf.bounds.left + 250, pdf.cursor], width: 150, height: 50) do
            pdf.text_box "Relatório de avarias", at: [pdf.bounds.left, pdf.bounds.top - 25], size: 10, align: :center
            pdf.stroke_bounds 
          end
        end
      end
    pdf.stroke_horizontal_rule

  
    
    pdf.bounding_box([pdf.bounds.left + 5, pdf.bounds.top - 170], width: pdf.bounds.width) do
      pdf.text_box "Chassi: ", size: 10, at: [pdf.bounds.left, pdf.bounds.top], size: 10
      pdf.text_box @vehicle.chassis, at: [pdf.bounds.left + 40, pdf.bounds.top], size: 10, style: :bold   
      pdf.text_box "Modelo: ", size: 10, at: [pdf.bounds.left, pdf.bounds.top - 15], size: 10
      pdf.text_box @vehicle.model, at: [pdf.bounds.left + 40, pdf.bounds.top - 15], size: 10, style: :bold   
    end
    pdf.move_down 50
    pdf.stroke_horizontal_rule
    pdf.move_down 10
    
    table1 = [
      ['Local', 'Navio', 'Data/Hora'],
      [@vehicle.location, @vehicle.ship, @vehicle.updated_at.to_s]
      
    ]
    table2 = [
      ["Observação: #{@vehicle.observations}"],
    ]
    
    pdf.table(table1) do |table|
      table.column_widths = [150, 150, 150]
      table.cells.style(size: 8)
      table.row(0).style(font_style: :bold)
    end
    
    pdf.table(table2) do |table|
      table.column_widths = [450]
      table.cells.style(size: 8)
    end

    pdf.move_down 20

    table3 = [["Avarias"],]
    table4 = [["Onde", "Local", "Quadrante", "Medida", "Dano"]]

    tablenonconformity = @vehicle.nonconformities.map { |nonconformity| 
      [VehiclePart.find(nonconformity.vehicleParts).name,
      NonconformityLocal.find(nonconformity.nonconformityLocals).local,
      Quadrant.find(nonconformity.quadrants).option,
      Measure.find(nonconformity.measures).size,
      NonconformityLevel.find(nonconformity.nonconformityLevels).level] 
    }
    
    pdf.table(table3) do |table|
      table.column_widths = [450]
      table.cells.style(size: 8, font_style: :bold)

    end

    pdf.table(table4) do |table|
      table.column_widths = [90, 90, 90, 90, 90]
      table.cells.style(size: 8, align: :center, font_style: :bold)

    end

    pdf.table(tablenonconformity) do |table|
      table.column_widths = [90, 90, 90, 90, 90]
      table.cells.style(size: 8, align: :center)
    end
    
    pdf.move_down 20
    
    table5 = [['CHASSI', 'VEÍCULO', 'PEÇA AVARIADA', 'AVARIA']]
    
    pdf.table(table5) do |table|
      table.column_widths = [112.5, 112.5, 112.5, 112.5]
      table.cells.style(border_color: 'FFFFFF', border_width: 0)
      table.cells.style(size: 8, align: :center)

    end

    table6 = []

    @vehicle.nonconformities.each_with_index do |nonconformity, index|
      chassi = StringIO.new(Base64.decode64(@vehicle.etChassisImage.sub('data:image/jpeg;base64,', '')))
      profile = StringIO.new(Base64.decode64(@vehicle.profileImage.sub('data:image/jpeg;base64,', '')))
      image1 = StringIO.new(Base64.decode64(nonconformity.image1.sub('data:image/jpeg;base64,', '')))
      image2 = StringIO.new(Base64.decode64(nonconformity.image2.sub('data:image/jpeg;base64,', '')))
      
      row = []
      if index == 0
        row << { image: chassi, image_width: 100, position: :center }
        row << { image: profile, image_width: 100, position: :center }
      else
        row << ''
        row << ''
      end
      row += [
        { image: image1, image_width: 100, position: :center },
        { image: image2, image_width: 100 , position: :center }
      ]
      table6 << row
    end
    
    pdf.table(table6) do |table|
      table.column_widths = [112.5, 112.5, 112.5, 112.5]
      table.cells.style(border_color: 'FFFFFF', border_width: 0)
    end

    pdf.canvas do 

      pdf.bounding_box([pdf.bounds.right - 300, pdf.bounds.bottom + 20], width: pdf.bounds.width) do
        pdf.move_down(5)
        pdf.text "IOS – Inteligência em Operações Sustentáveis"
    end
    end

    
    send_data(pdf.render,
    filename: "#{@vehicle.chassis}.pdf",
              type: 'application/pdf',
              disposition: 'inline'
             )
  end

  def new
    @vehicle = Vehicle.new
  end

  def edit; end

  def create
    preprocess_image_params(params)
    @vehicle = Vehicle.new(vehicle_params)

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to vehicle_url(@vehicle), notice: 'Vehicle was successfully created.' }
        format.json { render :show, status: :created, location: @vehicle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to vehicle_url(@vehicle), notice: 'Vehicle was successfully updated.' }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vehicle.destroy!

    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: 'Vehicle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def preprocess_image_params(params)
    %i[etChassisImage profileImage frontImage backImage rightSideImage leftSideImage].each do |image_attr|
      if params[:vehicle][image_attr].present?
        file = params[:vehicle][image_attr].tempfile
        encoded_data = Base64.strict_encode64(file.read)
        params[:vehicle][image_attr] = "data:#{params[:vehicle][image_attr].content_type};base64,#{encoded_data}"
      end
    end
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:location, :type, :chassis, :nonconformity, :model, :status, :ship, :situation, :observations, :etChassisImage, :profileImage, :frontImage, :backImage, :rightSideImage, :leftSideImage)
  end
end

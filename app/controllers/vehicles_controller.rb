class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[show edit update destroy show_pdf]
  skip_before_action :verify_authenticity_token, only: %i[create update]

  def index
    @ship = params[:ship]
    @chassis = params[:chassis]
    @model = params[:model]
    @situation = params[:situation]
    @nonconformity = params[:nonconformity]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    ship_and_travel = params[:ship_and_travel]
    if ship_and_travel.present?
      @ship, @travel = ship_and_travel.split('-').map(&:strip)
    end
  
    @vehicles = Vehicle.where(done: 'yes').where(:updated_at.ne => nil)
  
    @vehicles = @vehicles.where(ship: @ship) if @ship.present?
    @vehicles = @vehicles.where(travel: @travel) if @travel.present?
    @vehicles = @vehicles.where(:chassis => /#{@chassis}/i) if @chassis.present?
    @vehicles = @vehicles.where(model: /#{@model}/i) if @model.present?
    @vehicles = @vehicles.where(situation: /#{@situation}/i) if @situation.present?
    @vehicles = @vehicles.where(:nonconformity.gt => 0) if @nonconformity == "0"
    @vehicles = @vehicles.where(updated_at: @start_date..@end_date) if @start_date.present? && @end_date.present?
  
    @vehicles = @vehicles.order(updated_at: :desc)
  
    page = (params[:page] || 1).to_i
    per_page = 10
  
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

  
  
    pdf.bounding_box([pdf.bounds.left + 5, pdf.cursor - 15], width: pdf.bounds.width) do
      pdf.text_box "Chassi: ", size: 10, at: [pdf.bounds.left, pdf.bounds.top]
      pdf.text_box @vehicle.chassis, at: [pdf.bounds.left + 40, pdf.bounds.top], size: 10, style: :bold   
      pdf.text_box "Modelo: ", size: 10, at: [pdf.bounds.left, pdf.bounds.top - 15]
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
      [
      nonconformity.vehicleParts == "null" ? '' : VehiclePart.find(nonconformity.vehicleParts).name,
      nonconformity.nonconformityLocals == "null" ? '' : NonconformityLocal.find(nonconformity.nonconformityLocals).local,
      nonconformity.quadrants == "null" ? '' : Quadrant.find(nonconformity.quadrants).option,
      nonconformity.measures == "null" ? '' : Measure.find(nonconformity.measures).size,
      nonconformity.nonconformityTypes == "null" ? '' : NonconformityType.find(nonconformity.nonconformityTypes).nctype] 
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


    pdf.repeat(:all) do
      pdf.canvas do 
        pdf.bounding_box([pdf.bounds.right - 300, pdf.bounds.bottom + 20], width: pdf.bounds.width) do
          pdf.move_down(5)
          pdf.text "IOS – Inteligência em Operações Sustentáveis"
        end
      end
    end

    
    send_data(pdf.render,
    filename: "#{@vehicle.chassis}.pdf",
              type: 'application/pdf',
              disposition: 'inline'
             )
  end

  def index_pdf
    @ship = params[:ship]
    @chassis = params[:chassis]
    @model = params[:model]
    @situation = params[:situation]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @travel = params[:travel]

  
    @vehicles = Vehicle.where(done: 'yes').where(:updated_at.ne => nil)
  
    @vehicles = @vehicles.where(ship: @ship) if @ship.present?
    @vehicles = @vehicles.where(travel: @travel) if @travel.present?
    @vehicles = @vehicles.where(:chassis => /#{@chassis}/i) if @chassis.present?
    @vehicles = @vehicles.where(model: /#{@model}/i) if @model.present?
    @vehicles = @vehicles.where(situation: /#{@situation}/i) if @situation.present?
    @vehicles = @vehicles.where(updated_at: @start_date..@end_date) if @start_date.present? && @end_date.present?
  
    @vehicles = @vehicles.order(updated_at: :asc)
    
    pdf = Prawn::Document.new(page_size: 'A4', :margin => [70,70,70,70])
  
    image_width = 80
    x_coordinate = (pdf.bounds.width - image_width) / 2
  
    pdf.repeat(:all) do
      pdf.bounding_box([pdf.bounds.left, pdf.bounds.top, pdf.bounds.right, pdf.bounds.bottom], width: pdf.bounds.right, height: pdf.bounds.top - 600) do
        pdf.image Rails.root.join('app', 'assets', 'images', 'nexus.jpg'), width: image_width, at: [x_coordinate, pdf.bounds.top]
      end
    end
  
    pdf.bounding_box([pdf.bounds.left, pdf.cursor], width: pdf.bounds.width) do
    pdf.bounding_box([pdf.bounds.left, pdf.cursor], width: pdf.bounds.width, height: 150) do
      pdf.text "RELATÓRIO DE INSPEÇÃO", size: 10
      pdf.move_down 40
      pdf.text "1 – INFORMAÇÃO GERAL" , size: 10, align: :center, style: :bold   
      pdf.text_box "NOME DO NAVIO: ", size: 10, at: [pdf.bounds.left, pdf.bounds.top - 70], style: :bold  
      pdf.text_box @vehicles.first.ship, at: [pdf.bounds.left + 90, pdf.bounds.top - 70]
      pdf.text_box "Nº DA VIAGEM: ", size: 10, at: [pdf.bounds.left, pdf.bounds.top - 90], style: :bold  
      pdf.text_box @vehicles.first.travel, at: [pdf.bounds.left + 75, pdf.bounds.top - 90]
      pdf.text_box "DATA DA OPERAÇÃO: ", size: 10, at: [pdf.bounds.left, pdf.bounds.top - 110], style: :bold  
      pdf.text_box @vehicles.first.updated_at.strftime("%d/%m/%Y"), at: [pdf.bounds.left + 110, pdf.bounds.top - 110]
    end
    pdf.bounding_box([pdf.bounds.left, pdf.cursor, pdf.bounds.bottom], width: pdf.bounds.width, height: 100) do
      pdf.text "2 – INFORMAÇÕES DA OPERAÇÃO " , size: 10, align: :center, style: :bold 
      pdf.text_box "INICIO OPERAÇÃO / DESCARGA: ", size: 10, at: [pdf.bounds.left, pdf.bounds.top - 20], style: :bold  
      pdf.text_box  @vehicles.first.updated_at.strftime("%d/%m/%Y - %H:%M"), at: [pdf.bounds.left + 165, pdf.bounds.top - 20]
      pdf.text_box "FIM OPERAÇÃO DESCARGA: ", size: 10, at: [pdf.bounds.left, pdf.bounds.top - 40], style: :bold  
      pdf.text_box  @vehicles.last.updated_at.strftime("%d/%m/%Y - %H:%M"), at: [pdf.bounds.left + 145, pdf.bounds.top - 40]
      pdf.text_box "QUANTIDADE DE VEÍCULOS: ", size: 10, at: [pdf.bounds.left, pdf.bounds.top - 60], style: :bold  
      pdf.text_box  "#{@vehicles.count.to_s} VEÍCULOS", at: [pdf.bounds.left + 146, pdf.bounds.top - 60]
      pdf.text_box "VEÍCULOS AVARIADOS: ", size: 10, at: [pdf.bounds.left + 250, pdf.bounds.top - 60], style: :bold  
      pdf.text_box "#{@vehicles.where(:nonconformity.gt => 0).count} VEÍCULO(S)", at: [pdf.bounds.left + 370, pdf.bounds.top - 60]
    end

    header = [["MARCA", "MODELO", "Unidades", "Total Avariados", "%"]]

    vehicles = @vehicles.group_by(&:model)
    
    vehicle_data = vehicles.map do |model, vehicles_for_model|
      total_units = vehicles_for_model.size
      total_faulty = vehicles_for_model.count { |vehicle| vehicle.nonconformity.to_i > 0 }
      total_faulty == 0 ? percentage = nil : percentage = total_faulty.to_f / total_units * 100
      
    
      [vehicles_for_model.first.brand, model, total_units, total_faulty, percentage.nil? ? '' : "#{percentage.round(2)}%"]
    end
    
      pdf.text "3 – ESTATISCA DE DESCARREGAMENTO" , size: 10, align: :center, style: :bold 
      pdf.move_down 10

      pdf.table(header + vehicle_data) do |table|
        table.column_widths = [90, 190, 50, 80, 40]
        table.row(0).font_style = :bold
        table.cells.style(size: 8, align: :center)
      end
    
      pdf.move_down 30



    header = ["CHASSI", "MODELO", "ÁREA", "QUADRANTE", "DANOS"]

    rows = []

    @vehicles.each do |vehicle|
      vehicle.nonconformities.each do |nonconformity|
        vehicle_part = VehiclePart.find(nonconformity.vehicleParts).name
        quadrant = Quadrant.find(nonconformity.quadrants).option
        nonconformity_types = NonconformityLevel.find(nonconformity.nonconformityLevels).level

        rows << [vehicle.chassis, vehicle.model, vehicle_part, quadrant, nonconformity_types]
      end
    end

    pdf.text "4 – RELATÓRIO DE AVARIAS" , size: 10, align: :center, style: :bold 
    pdf.move_down 10

    pdf.table([header] + rows) do |table|
      table.column_widths = [100, 115, 115, 60, 60]

      table.row(0).font_style = :bold
      table.cells.style(size: 8, align: :center)
    end

    pdf.move_down 30
    pdf.text "5 – FOTOS DAS AVARIAS" , size: 10, align: :center, style: :bold 
    pdf.move_down 10

    headerPhotos = [['CHASSI', 'VEÍCULO', 'PEÇA AVARIADA', 'AVARIA']]

    photos = []

    errors = []

    @vehicles.where.gt(nonconformity: 0).order(updated_at: :asc).each do |vehicle|
      vehicle.nonconformities.each_with_index do |nonconformity, index|
        begin
          chassi = StringIO.new(Base64.decode64(vehicle.etChassisImage.sub('data:image/jpeg;base64,', '')))
          profile = StringIO.new(Base64.decode64(vehicle.profileImage.sub('data:image/jpeg;base64,', '')))
          image1 = StringIO.new(Base64.decode64(nonconformity.image1.sub('data:image/jpeg;base64,', '')))
          image2 = StringIO.new(Base64.decode64(nonconformity.image2.sub('data:image/jpeg;base64,', '')))
        rescue StandardError => e
          errors << "Error decoding image for vehicle #{vehicle.chassis}: #{e.message}"
          next
        end
        
        row = [
          { image: chassi, image_width: 100, position: :center },
          { image: profile, image_width: 100, position: :center },
          { image: image1, image_width: 100, position: :center },
          { image: image2, image_width: 100, position: :center }
        ]
        photos << row
    
        vehicle_row = [vehicle.chassis, vehicle.model, VehiclePart.find(nonconformity.vehicleParts).name, NonconformityType.find(nonconformity.nonconformityTypes).nctype]
        photos << vehicle_row
      end
    end
    
    pdf.table(headerPhotos + photos, cell_style: { inline_format: true }) do |table|
      table.header = 1
      table.cells.style(size: 6, align: :center)
      table.column_widths = [112.5, 112.5, 112.5, 112.5]
      table.cells.style(border_color: 'FFFFFF', border_width: 0)
      table.cells.style(size: 6, align: :center)
    end

  end
  
    send_data pdf.render,
      filename: "vehicles.pdf",
      type: 'application/pdf',
      disposition: 'inline'
  end

  def new
    @vehicle = Vehicle.new
  end

  def edit; end

  def create
    @vehicle = Vehicle.new(vehicle_params)

    respond_to do |format|
      if @vehicle.save

        begin
          # Get the MongoDB client and create a GridFS bucket
          client = Mongoid::Clients.default
          bucket = Mongo::Grid::FSBucket.new(client.database)
  
          # Process each image if present, upload to GridFS, and update the vehicle document
          if params[:vehicle][:etChassisImage].present?
            et_file = params[:vehicle][:etChassisImage]
            et_file_id = bucket.upload_from_stream(et_file.original_filename, et_file.tempfile)
            @vehicle.update(
              et_chassis_image_filename: et_file.original_filename,
              et_chassis_image_gridfs_id: et_file_id.to_s
            )
          end
  
          if params[:vehicle][:profileImage].present?
            profile_file = params[:vehicle][:profileImage]
            profile_file_id = bucket.upload_from_stream(profile_file.original_filename, profile_file.tempfile)
            @vehicle.update(
              profile_image_filename: profile_file.original_filename,
              profile_image_gridfs_id: profile_file_id.to_s
            )
          end
  
          if params[:vehicle][:frontImage].present?
            front_file = params[:vehicle][:frontImage]
            front_file_id = bucket.upload_from_stream(front_file.original_filename, front_file.tempfile)
            @vehicle.update(
              front_image_filename: front_file.original_filename,
              front_image_gridfs_id: front_file_id.to_s
            )
          end
  
          if params[:vehicle][:backImage].present?
            back_file = params[:vehicle][:backImage]
            back_file_id = bucket.upload_from_stream(back_file.original_filename, back_file.tempfile)
            @vehicle.update(
              back_image_filename: back_file.original_filename,
              back_image_gridfs_id: back_file_id.to_s
            )
          end
  
        rescue => e
          Rails.logger.error("GridFS upload error: #{e.message}")
        end

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

  def set_vehicles
    @query = params[:query]
    if @query.present?
      @vehicles = Vehicle.any_of(
        { chassis: /#{@query}/i },
        { model: /#{@query}/i },
        { location: /#{@query}/i },
        { ship: /#{@query}/i },
        { situation: /#{@query}/i },
        { nonconformity: /#{@query}/i }
      ).where(done: 'yes', :updated_at.ne => nil).order(updated_at: :asc)
    else
      @vehicles = Vehicle.all.where(done: 'yes', :updated_at.ne => nil).order(updated_at: :asc)
    end
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:location, :type, :chassis, :nonconformity, :model, :status, :ship, :situation, :observations,  :travel, :done)
  end
end

class Vehicle
  include Mongoid::Document
  include Mongoid::Timestamps

  field :location, type: String
  field :type, type: String
  field :chassis, type: String
  field :nonconformity, type: Integer
  field :brand, type: String
  field :travel, type: String
  field :model, type: String
  field :status, type: String
  field :ship, type: String
  field :situation, type: String
  field :observations, type: String
  field :done, type: String, default: "no"

  #----------------------------------------------------

  field :etChassisImage, type: String
  field :profileImage, type: String

  #----------------------------------------------------

  field :et_chassis_image_filename, type: String
  field :et_chassis_image_gridfs_id, type: String

  field :profile_image_filename, type: String
  field :profile_image_gridfs_id, type: String

  field :front_image_filename, type: String
  field :front_image_gridfs_id, type: String

  field :back_image_filename, type: String
  field :back_image_gridfs_id, type: String


  has_many :nonconformities, dependent: :destroy


  after_create :broadcast_create
  after_update :broadcast_update
  after_destroy :broadcast_destroy

  private

  
  def broadcast_create
    vehicles = Vehicle.where(done: 'yes').where(:updated_at.ne => nil).order(updated_at: :desc)
    ActionCable.server.broadcast "vehicles_channel", {
      action: "create",
      vehicles: vehicles.as_json
    }
  end

  def broadcast_update
    vehicles = Vehicle.where(done: 'yes').where(:updated_at.ne => nil).order(updated_at: :desc)
    ActionCable.server.broadcast "vehicles_channel", {
      action: "update",
      vehicles: vehicles.as_json
    }
  end

  def broadcast_destroy
    vehicles = Vehicle.where(done: 'yes').where(:updated_at.ne => nil).order(updated_at: :desc)
    ActionCable.server.broadcast "vehicles_channel", {
      action: "destroy",
      vehicles: vehicles.as_json
    }
  end
end
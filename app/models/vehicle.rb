class Vehicle
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :etChassisImage, FileUploader
  mount_uploader :profileImage, FileUploader
  mount_uploader :frontImage, FileUploader
  mount_uploader :backImage, FileUploader
  mount_uploader :rightSideImage, FileUploader
  mount_uploader :leftSideImage, FileUploader

  field :location, type: String
  field :type, type: String
  field :chassis, type: String
  field :nonconformity, type: Integer
  field :model, type: String
  field :status, type: String
  field :ship, type: String
  field :situation, type: String
  field :observations, type: String
  field :done, type: String, default: "no"

  has_many :nonconformities, dependent: :destroy

end

class Nonconformity
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :image1, FileUploader
  mount_uploader :image2, FileUploader
  mount_uploader :image3, FileUploader
  mount_uploader :image4, FileUploader

  field :vehicleParts, type: String
  field :nonconformityTypes, type: String
  field :nonconformityLevels, type: String
  field :quadrants, type: String
  field :measures, type: String
  field :nonconformityLocals, type: String
  belongs_to :vehicle
end
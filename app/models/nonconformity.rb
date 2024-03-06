class Nonconformity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :image1, type: String
  field :image2, type: String
  field :image3, type: String
  field :image4, type: String

  field :vehicleParts, type: String
  field :nonconformityTypes, type: String
  field :nonconformityLevels, type: String
  field :quadrants, type: String
  field :measures, type: String
  field :nonconformityLocals, type: String
  belongs_to :vehicle
end
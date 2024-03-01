class VehiclePart
  include Mongoid::Document
  include Mongoid::Timestamps
  field :area, type: Integer
  field :name, type: String
end

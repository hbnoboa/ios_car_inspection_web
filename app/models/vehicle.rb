class Vehicle
  include Mongoid::Document
  include Mongoid::Timestamps

  field :etChassisImage, type: String 
  field :profileImage, type: String 
  field :frontImage, type: String 
  field :backImage, type: String 
  field :rightSideImage, type: String 
  field :leftSideImage, type: String 

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

  has_many :nonconformities, dependent: :destroy

end

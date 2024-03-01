class Measure
  include Mongoid::Document
  include Mongoid::Timestamps
  field :size, type: String
end

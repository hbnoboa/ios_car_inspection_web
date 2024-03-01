class NonconformityLevel
  include Mongoid::Document
  include Mongoid::Timestamps
  field :level, type: String
end

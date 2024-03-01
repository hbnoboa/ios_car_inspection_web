class NonconformityType
  include Mongoid::Document
  include Mongoid::Timestamps
  field :nctype, type: String
end

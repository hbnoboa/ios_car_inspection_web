class NonconformityLocal
  include Mongoid::Document
  include Mongoid::Timestamps
  field :local, type: String
end

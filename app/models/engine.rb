class Engine
  include Mongoid::Document
  
  embedded_in :plane
  
  field :name, type: String
  
end

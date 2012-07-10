class Address
  include Mongoid::Document
  
  embedded_in :plane
  
  field :street, type: String
  field :city, type: String
  field :state, type: String
  field :latitude, type: Float
  field :longitude, type: Float
  
end

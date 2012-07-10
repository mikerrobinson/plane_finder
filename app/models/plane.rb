class Plane
  include Mongoid::Document
  
  belongs_to :user
  embeds_one :address
  embeds_many :engines
  
  field :category, type: String, default: "Single Engine Piston"
  field :make, type: String
  field :model, type: String
  field :year, type: Integer
  field :name, type: String
  field :tags, type: String
  field :tail_number, type: String
  field :rental_amount, type: BigDecimal
  field :rental_type, type: String
  field :notes, type: String
  field :based_at, type: String
  
end

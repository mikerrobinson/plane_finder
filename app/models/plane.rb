class Plane
  include Mongoid::Document
  include Mongoid::FullTextSearch
  
  belongs_to :user
  embeds_one :address
  
  accepts_nested_attributes_for :address
  
  field :classification, type: String, default: "Single Engine Piston"
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
  
  fulltext_search_in :make, :model, :name, :tags, :tail_number, :based_at
  
end

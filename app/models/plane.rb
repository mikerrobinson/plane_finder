class Plane
  include Mongoid::Document
  include Mongoid::FullTextSearch
  
  belongs_to :user
  embeds_one :address
  
  accepts_nested_attributes_for :address
    
  field :base_airport, type: String
  field :name, type: String
  field :tail_number, type: String
  field :description, type: String
  field :rental_amount, type: BigDecimal
  field :rental_type, type: String

  validates_presence_of :base_airport
  validate :has_a_name
  
  # these may be auto-populated by parsing :description
  field :classification, type: String, default: "Single Engine Piston"
  field :tags, type: String
  field :make, type: String
  field :model, type: String
  field :year, type: Integer

  fulltext_search_in :make, :model, :name, :tags, :tail_number, :base_airport
  
  def has_a_name
    if name.blank? and tail_number.blank?
      errors.add(:name, "Either tail number or name (or both) must be provided")
    end
  end
  
end

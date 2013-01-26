class Plane
  include Mongoid::Document
  # include Mongoid::FullTextSearch
  include Geocoder::Model::Mongoid
  resourcify
  
  CATEGORIES = %w( Land Sea Amphibian )
  ENDORSEMENTS = [ "High performance", "Complex", "Tailwheel", "Acrobatics" ]
  AIRCRAFT_TYPES = [ "Glider", "Balloon", "Blimp/Dirigible", "Fixed wing single engine", "Fixed wing multi engine", "Rotorcraft", "Weight-shift-control", "Powered Parachute", "Gyroplane" ]
  ENGINE_TYPES = [ "None", "Reciprocating", "Turbo-prop", "Turbo-shaft", "Turbo-jet", "Turbo-fan", "Ramjet", "2 Cycle", "4 Cycle", "Unknown", "Electric", "Rotary" ]

  attr_accessible :image_url, :base_airport, :name, :code, :category, :endorsements, :tail_number, :notes_text,
                  :rental_amount, :rental_type, :tags, :manufacturer, :model, :year, :school_id,
                  :category_value, :endorsement_values, :aircraft_type_value, :engine_type_value
  
  geocoded_by :address               # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  
  belongs_to :school, inverse_of: :plane

  field :tail_number
  field :manufacturer
  field :model
  field :category, type: Integer, default: 1
  field :cert_type, type: Integer
  field :engines, type: Integer, default: 1
  field :seats, type: Integer
  field :weight, type: Integer
  field :hp, type: Integer
  field :thrust, type: Integer
  field :year, type: Integer
  field :aircraft_type, type: Integer, default: 4
  field :engine_type, type: Integer, default: 1
  embeds_one :owner  
    
  field :image_url, type: String
  field :base_airport, type: String
  field :name, type: String
  field :code, type: String
  field :endorsements, type: Array, default: []
  field :notes_text, type: String
  field :rental_amount, type: BigDecimal
  field :rental_type, type: String, default: "wet"
  field :external_url, type: String

  field :coordinates, :type => Array
  field :address, type: String
  field :tags, type: String

  index({ tail_number: 1}, { unique: true })
  # index base_airport: 1
  # index make: 1
  # index :model => 1

  validates :tail_number, uniqueness: true, allow_blank: true
 
  def endorsement_values
    endorsements.map { |v| ENDORSEMENTS[v] }
  end
  
  def endorsement_values= values
    self.endorsements = values.reject!(&:empty?).map { |v| ENDORSEMENTS.index(v) }
  end
  
  def category_value
    CATEGORIES[category - 1]
  end
  
  def category_value= value
    self.category = CATEGORIES.index(value) + 1
  end
  
  def aircraft_type_value
    AIRCRAFT_TYPES[aircraft_type - 1]
  end
  
  def aircraft_type_value= value
    self.aircraft_type = AIRCRAFT_TYPES.index(value) + 1
  end
  
  def engine_type_value
    ENGINE_TYPES[engine_type]
  end
  
  def engine_type_value= value
    self.engine_type = ENGINE_TYPES.index(value)
  end
  
  def rental
    return "" unless rental_amount 
    "#{rental_amount}/hr #{rental_type}"
  end
  
  def abbreviated_type
    return "ASEL" if category==1 and aircraft_type==4
    return "AMEL" if category==1 and aircraft_type==5
    return "ASES" if category==2 and aircraft_type==4
    return "AMES" if category==2 and aircraft_type==5
    return "Helicopter" if aircraft_type==6
    "#{Plane::AIRCRAFT_TYPES[aircraft_type-1]} #{Plane::CATEGORIES[category-1]}"
  end
  
end

class Owner
  include Mongoid::Document

  field :street1
  field :street2
  field :city
  field :state
  field :zipcode
  
  embedded_in :plane
end

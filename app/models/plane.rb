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
                  :rental_amount, :rental_type, :tags, :make, :model, :year, :school_id
  
  geocoded_by :address               # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  
  belongs_to :school, inverse_of: :plane

  field :tail_number
  field :manufacturer
  field :model
  field :category, type: Integer
  field :cert_type, type: Integer
  field :engines, type: Integer
  field :seats, type: Integer
  field :weight, type: Integer
  field :hp, type: Integer
  field :thrust, type: Integer
  field :year, type: Integer
  field :aircraft_type, type: Integer
  field :engine_type, type: Integer
  embeds_one :owner  
    
  field :image_url, type: String
  field :base_airport, type: String
  field :name, type: String
  field :code, type: String
  field :endorsements, type: Integer
  field :notes_text, type: String
  field :rental_amount, type: BigDecimal
  field :rental_type, type: String
  field :coordinates, :type => Array
  field :address, type: String
  field :tags, type: String

  index({ tail_number: 1}, { unique: true })
  # index base_airport: 1
  # index make: 1
  # index :model => 1

  validates :tail_number, uniqueness: true, allow_blank: true
 
  #  
  # def endorsements=(endorsements)
  #   self.endorsements_mask = (endorsements & ENDORSEMENTS).map { |r| 2**ENDORSEMENTS.index(r) }.inject(0, :+)
  # end
  # 
  # def endorsements
  #   ENDORSEMENTS.reject do |r|
  #     ((endorsements_mask || 0) & 2**ENDORSEMENTS.index(r)).zero?
  #   end
  # end
  # 
  # def self.endorsements endorsements_mask
  #   ENDORSEMENTS.reject do |r|
  #     ((endorsements_mask || 0) & 2**ENDORSEMENTS.index(r)).zero?
  #   end
  # end
  # 
  # def self.endorsements_mask endorsements
  #   (endorsements & ENDORSEMENTS).map { |r| 2**ENDORSEMENTS.index(r) }.inject(0, :+)
  # end
  
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

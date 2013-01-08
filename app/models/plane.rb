class Plane
  include Mongoid::Document
  # include Mongoid::FullTextSearch
  include Geocoder::Model::Mongoid
  resourcify
  
  CATEGORIES = [  "Airplane Single-Engine Land",
                  "Airplane Single-Engine Sea",
                  "Airplane Multi-Engine Land",
                  "Airplane Multi-Engine Sea",
                  "Helicopter",
                  "Lighter-than-air",
                  "Powered parachute",
                  "Weight-shift-control",
                  "Simulator"]
                  
  ENDORSEMENTS = [ "High performance",
                   "Complex",
                   "Tailwheel",
                   "Aerobatics",
                   "Light sport",
                   "Turbine"]
                   
  attr_accessible :image_url, :base_airport, :name, :code, :category, :endorsements, :tail_number, :notes_text,
                  :rental_amount, :rental_type, :tags, :make, :model, :year, :school_id
  
  geocoded_by :address               # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  
  belongs_to :school, inverse_of: :plane
  
  field :image_url, type: String
  field :base_airport, type: String
  field :name, type: String
  field :code, type: String
  field :category, type: String, default: "Airplane Single-Engine Land"
  field :endorsements, type: Array
  field :tail_number, type: String
  field :notes_text, type: String
  field :rental_amount, type: BigDecimal
  field :rental_type, type: String, default: "wet"
  field :coordinates, :type => Array
  field :address, type: String
  
  validates_presence_of :base_airport
  # validate :has_a_name
  validates :tail_number, uniqueness: true, allow_blank: true
  
  # these may be auto-populated by parsing :description
  field :tags, type: String
  field :make, type: String
  field :model, type: String
  field :year, type: Integer

  # fulltext_search_in :make, :model, :name, :tags, :tail_number, :base_airport
  # 
  # def has_a_name
  #   if name.blank? and tail_number.blank?
  #     errors.add(:name, "Either tail number or name (or both) must be provided")
  #   end
  # end
  
end

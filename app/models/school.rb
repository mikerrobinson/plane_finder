class School
  include Mongoid::Document
  include Geocoder::Model::Mongoid
  resourcify
  
  geocoded_by :address               # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  
  attr_accessible :website, :phone, :address, :image_url, :base_airport, :name, :admins

  field :name, type: String
  field :website, :type => String
  field :email, :type => String
  field :phone, :type => String
  field :address, :type => String
  field :image_url, type: String
  field :base_airport, type: String  
  field :coordinates, :type => Array
  
  has_many :planes, inverse_of: :school
  has_many :users

  validates_uniqueness_of :email, :case_sensitive => false
  validates_presence_of :name
end

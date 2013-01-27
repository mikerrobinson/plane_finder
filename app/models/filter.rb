class Filter
  include Mongoid::Document

  field :query
  field :endorsements, :type => Array, :default => Plane::ENDORSEMENTS
  field :aircraft_types, :type => Array, :default => Plane::AIRCRAFT_TYPES
  field :engine_types, :type => Array, :default => Plane::ENGINE_TYPES
  field :categories, :type => Array, :default => Plane::CATEGORIES
  field :airports, :type => Array
  
  def initialize params
    if params
      return super(params) if params[:previous_query] == params[:query]
      return super({ query: params[:query] })
    else
      return super
    end    
  end
  
end

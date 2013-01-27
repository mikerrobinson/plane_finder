class PlanesController < ApplicationController
  respond_to :html, :json
  
  before_filter :authenticate_user!, except: [ :search, :show ]
  
  def index

    selection = Plane.all
    
    # reset the filter if keywords changed
    @filter = Filter.new(params[:filter])

    case @filter.query
    when /^N[1-9][0-9]{0,4}$|^N[1-9][0-9]{0,3}[A-Z]$|^N[1-9][0-9]{0,2}[A-Z]{2}$/i
      selection = Plane.where(tail_number: @filter.query[1..-1].upcase)
    when /^K\w{3,4}$/i
      selection = Plane.where(base_airport: @filter.query.upcase)
    when /^\w{3,4}$/i
      selection = Plane.where(base_airport: "K#{@filter.query.upcase}")
      selection = Plane.near(@filter.query) if selection.count == 0
    when present?
      selection = Plane.near(@filter.query)
    end

    @category_options = selection.distinct(:category).sort.map { |i| Plane::CATEGORIES[i-1] }
    @aircraft_type_options = selection.distinct(:aircraft_type).sort.map { |i| Plane::AIRCRAFT_TYPES[i-1] }
    @engine_type_options = selection.distinct(:engine_type).sort.map { |i| Plane::ENGINE_TYPES[i-1] }
    @endorsement_options = selection.distinct(:endorsements).sort.map { |i| Plane::ENDORSEMENTS[i] }

    selection = filter_endorsements(selection) if @filter.endorsements
    selection = filter_categories(selection) if @filter.categories
    selection = filter_aircraft_types(selection) if @filter.aircraft_types
    selection = filter_engine_types(selection) if @filter.engine_types
    
    @planes = selection.page(params[:page])
    respond_with @planes
  end

  def show 
    if params[:id].upcase =~ /^[1-9][0-9]{0,4}$|^[1-9][0-9]{0,3}[A-Z]$|^[1-9][0-9]{0,2}[A-Z]{2}$/
      @plane = Plane.find_by(tail_number: params[:id].upcase)
    else
      @plane = Plane.find(params[:id])
    end
    respond_with @plane
  end
  
  def edit
    @plane = Plane.find(params[:id])

    respond_with @plane do |format|
      format.html { render :layout => false }
      format.json { render :layout => false, :text => @plane.to_json }
    end
  end

  def update
    @plane = Plane.find(params[:id])
    @plane.address = Geocoder.address(params[:plane][:base_airport])
    @plane.update_attributes(params[:plane])
    render "show", layout: false
    
    # if @plane.update_attributes(params[:plane])
    #   flash[:success] = "Airplane information updated"
    #   redirect_to planes_path
    # else
    #   render 'edit'
    # end
  end
  
  def new
    @plane = Plane.new
    respond_with @plane do |format|
      format.html { render :layout => false }
      format.json { render :layout => false, :text => @plane.to_json }
    end
  end
  
  def create
    @plane = Plane.new(params[:plane])
    @plane.address = Geocoder.address(params[:plane][:base_airport])
    if @plane.save
      flash[:success] = t("plane.created")
      redirect_to planes_path
    else
      render 'new'
    end
  end

  def destroy
    @plane = Plane.find(params[:id])
    @plane.destroy

    respond_to do |format|
      format.html { redirect_to planes_url }
      format.json { head :no_content }
    end
  end
  
  def search
    # results = Plane.near(params[:search])
    # 
    # @planes = results.page(params[:page])
    # @airports = results.map { |plane| plane.base_airport.upcase }.uniq
    # @models = [] # @planes.map { |plane| plane.model.humanize }.uniq
    # 
    
    selection = Plane.all
    
    # reset the filter if keywords changed
    params[:filter] ||= { query: params[:search] }
    @filter = Filter.new(params[:filter])

    case @filter.query
    when /^N[1-9][0-9]{0,4}$|^N[1-9][0-9]{0,3}[A-Z]$|^N[1-9][0-9]{0,2}[A-Z]{2}$/i
      selection = Plane.where(tail_number: @filter.query[1..-1].upcase)
    when /^K\w{3,4}$/i
      selection = Plane.where(base_airport: @filter.query.upcase)
    when /^\w{3,4}$/i
      selection = Plane.where(base_airport: "K#{@filter.query.upcase}")
      selection = Plane.near(@filter.query) if selection.count == 0
    else
      selection = Plane.near(@filter.query)
    end


    # @category_options = selection.distinct(:category).sort.map { |i| Plane::CATEGORIES[i-1] }
    # @aircraft_type_options = selection.distinct(:aircraft_type).sort.map { |i| Plane::AIRCRAFT_TYPES[i-1] }
    # @engine_type_options = selection.distinct(:engine_type).sort.map { |i| Plane::ENGINE_TYPES[i-1] }
    @endorsement_options = selection.distinct(:endorsements).sort.map { |i| Plane::ENDORSEMENTS[i] }
    @airport_options = selection.distinct(:base_airport).sort
    
    @filter.airports = @airport_options unless params[:filter][:previous_query] == params[:filter][:query]
    
    selection = filter_endorsements(selection) if @filter.endorsements
    selection = filter_airports(selection) if @filter.airports
    
    # selection = filter_categories(selection) if @filter.categories
    # selection = filter_aircraft_types(selection) if @filter.aircraft_types
    # selection = filter_engine_types(selection) if @filter.engine_types
    
    @planes = selection.page(params[:page])
    respond_with @planes    
    
    
    
    
  end

  private
  
  def filter_endorsements scope
    return scope if @filter.endorsements.length == @endorsement_options.length + 1
    included_values = @filter.endorsements.reject { |c| c.empty? }.inject([{endorsements:[]}]) { |s,e| s << { endorsements: Plane::ENDORSEMENTS.index(e) } }
    # included_values = (0..3).select { |v| @filter.endorsements.include?(Plane::ENDORSEMENTS[v]) }
    scope.any_of(included_values)
  end

  def filter_airports scope
    scope.any_in(base_airport: @filter.airports)
  end
  
  def filter_categories scope
    return scope if @filter.categories.length == @category_options.length + 1
    included_values = @filter.categories.reject { |c| c.empty? }.map { |e| Plane::CATEGORIES.index(e) + 1 }
    scope.any_in(category: included_values)
  end

  def filter_aircraft_types scope
    return scope if @filter.aircraft_types.length == @aircraft_type_options.length + 1
    included_values = @filter.aircraft_types.reject { |c| c.empty? }.map { |e| Plane::AIRCRAFT_TYPES.index(e) + 1 }
    scope.any_in(aircraft_type: included_values)
  end
  
  def filter_engine_types scope
    return scope if @filter.engine_types.length == @engine_type_options.length + 1
    included_values = @filter.engine_types.reject { |c| c.empty? }.map { |e| Plane::ENGINE_TYPES.index(e) }
    scope.any_in(engine_type: included_values)
  end

end

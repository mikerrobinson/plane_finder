class PlanesController < ApplicationController
  respond_to :html, :json
  
  before_filter :authenticate_user!, except: [ :search ]
  
  def index
    User.find_or_create_by(email: "samir.kanuga@gmail.com").tap do |user|
      user.password = "password"
      user.admin = true
      user.save
    end
    
    @planes = []
    @planes = current_user.school.planes unless current_user.school.blank?
    @planes = Plane.all if current_user.admin
    respond_with @planes
  end
  
  def show 
    @plane = Plane.find(params[:id])
  end
  
  def edit
    @plane = Plane.find(params[:id])
  end

  def update
    @plane = Plane.find(params[:id])
    if @plane.update_attributes(params[:plane])
      flash[:success] = "Airplane information updated"
      redirect_to planes_path
    else
      render 'edit'
    end
  end
  
  def new
    @plane = Plane.new
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
    @planes = Plane.near(params[:search])
    @airports = @planes.map { |plane| plane.base_airport.upcase }.uniq
    @models = [] # @planes.map { |plane| plane.model.humanize }.uniq
  end
  
end

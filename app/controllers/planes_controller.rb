class PlanesController < ApplicationController
  
  before_filter :authenticate_user!, except: [ :search ]
  
  def index
    @planes = Plane.all
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
    if @plane.save
      flash[:success] = t("plane.created")
      redirect_to planes_path
    else
      render 'new'
    end
  end

  def search
    @planes = Plane.fulltext_search(params[:search])
  end
  
end

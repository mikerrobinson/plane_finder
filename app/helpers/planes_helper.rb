module PlanesHelper
  
  def table_header
    if params[:search].blank?
      "All Planes"
    else
      "Planes matching '#{params[:search]}'"
    end
  end
  
end

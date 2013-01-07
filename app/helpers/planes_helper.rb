module PlanesHelper
  
  def formatted_name(plane)
    "#{plane.year} #{plane.make} #{plane.model}"
  end
    
end

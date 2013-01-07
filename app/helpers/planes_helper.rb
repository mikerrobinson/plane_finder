module PlanesHelper
  
  def formatted_name(plane)
    "#{plane.year} #{plane.make} #{plane.model}"
  end
    
  def formatted_cost(plane)
    "$#{sprintf("%5.0f",plane.rental_amount)}/hr #{plane.rental_type}"
  end
    
end

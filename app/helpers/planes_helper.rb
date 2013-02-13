module PlanesHelper
  
  def formatted_name(plane)
    "#{plane.year} #{plane.make} #{plane.model}"
  end
    
  def formatted_cost(plane)
    "$#{sprintf("%5.0f",plane.rental_amount)}/hr #{plane.rental_type}"
  end

  def rental_text(rental_amount)
    return "$#{rental_amount.to_i}/hr" if rental_amount.to_i > 0
    return I18n.t("views.planes.rental_amount_na")
  end
  
end

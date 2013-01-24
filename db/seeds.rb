# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

engines = {}
aircraft = {}

puts "Parsing ENGINE.txt..."
CSV.foreach("ENGINE.txt", headers: true, :quote_char => "|") do |row|
  info = {}
  info[:hp] = row[4].to_i unless row[4].to_i == 0
  info[:thrust] = row[5].to_i unless row[4].to_i == 0
  engines[row[0]] = info unless info.empty?
end

puts "Parsing ACFTREF.txt..."
CSV.foreach("ACFTREF.txt", headers: true, :quote_char => "|") do |row|
  Hash.new.tap do |h|
    h[:manufacturer] = row["MFR"].strip
    h[:model] = row["MODEL"].strip
    h[:category] = row["AC-CAT"].to_i
    h[:cert_type] = row["BUILD-CERT-IND"].to_i
    h[:engines] = row["NO-ENG"].to_i
    h[:seats] = row["NO-SEATS"].to_i
    h[:weight] = row["AC-WEIGHT"].to_i
    aircraft[row[0]] = h
  end
end

count = 0
puts "Parsing MASTER.txt..."
File.open("planes.json", "wb") do |json|
  CSV.foreach("MASTER.txt", headers: true, :quote_char => "|") do |row|
    count += 1
    puts "#{count}" if (count % 10000 == 0)
    
    Hash.new.tap do |plane|
      plane[:tail_number] = row[0].strip
      plane[:year] = row["YEAR MFR"].to_i unless row[4].blank?
      plane[:aircraft_type] = row["TYPE AIRCRAFT"].to_i
      plane[:engine_type] = row["TYPE ENGINE"].to_i
      
      plane.merge!(aircraft[row["MFR MDL CODE"]]) if aircraft.has_key? row["MFR MDL CODE"]
      plane.merge!(engines[row["ENG MFR MDL"]]) if engines.has_key? row["ENG MFR MDL"]

      # endorsements = []
      # endorsements << "High performance" if plane.has_key?(:hp) and plane[:hp] > 200
      # endorsements << "Acrobatics" if row["CERTIFICATION"] =~ /^1.*A.*/
      #     
      # plane[:endorsements] = (endorsements & Plane::ENDORSEMENTS).map { |r| 2**Plane::ENDORSEMENTS.index(r) }.inject(0, :+)

      endorsements = []
      endorsements << 0 if plane.has_key?(:hp) and plane[:hp] > 200
      endorsements << 3 if row["CERTIFICATION"] =~ /^1.*A.*/
      plane[:endorsements] = endorsements

      json.puts plane.to_json
    end
    
  end
end
require 'csv'

namespace :faa do

  CATEGORIES = [  "Airplane Single-Engine Land",
                  "Airplane Single-Engine Sea",
                  "Airplane Multi-Engine Land",
                  "Airplane Multi-Engine Sea",
                  "Helicopter",
                  "Simulator"]
                  
  ENDORSEMENTS = [ "High performance",
                   "Complex",
                   "Tailwheel",
                   "Aerobatics",
                   "Light sport",
                   "Turbine"]
  
  # engine types that should include a horsepower rating (for high perf calculation)
  PISTON_ENGINE_TYPES = [ "1 ", "2 ", "3 ", "7 ", "8 " ]
  
  # engine types that require turbine endorsement
  JET_ENGINE_TYPES = [ "4 ", "5 ", "6 " ]
  
  task :transform do
    
    engines = {}
    models = {}
    planes = {}

    puts "Parsing ENGINE.txt"
    CSV.foreach("ENGINE.txt", headers: true, :quote_char => "|") do |row|
      engines[row[0]] = row[4].to_i if PISTON_ENGINE_TYPES.include?(row[3])
    end
    
    CSV.foreach("ACFTREF.txt", headers: true, :quote_char => "|") do |row|
      endorsements = []
      endorsements << 4 if row[6]==="2"
      # endorsements += 5 if JET_ENGINE_TYPES.include?(row[4])

      # make, model, category, endorsement array
      # (currently excludes gliders)
      new_model = [ row[1].strip, row[2].strip, classification(row[3], row[5]), endorsements ]
      models[row[0]] = new_model unless new_model[2].blank?
    end
    
    
    count = 0
    puts "Parsing MASTER.txt"
    File.open("OUTPUT.json", "wb") do |json|
      # csv << [ :tail_number, :make, :model, :year, :category, :endorsements, :address ]
      CSV.foreach("MASTER.txt", headers: true, :quote_char => "|") do |row|
        count += 1
        puts "#{count}" if (count % 10000 == 0)
        if models[row[2]].present? and [0,1,2,3,7,8].include?(row['TYPE ENGINE'].to_i)
          endorsements = models[row[2]][3]
          endorsements << 0 if engines.has_key?(row[3]) and engines[row[3]] > 200
          endorsements << 3 if row["CERTIFICATION"][1]==="A"

          # new_plane = { t:     row[0].strip,           # tail_number 
          #               mfr:            models[row[2]][0],      # make        
          #               mdl:           models[row[2]][1],      # model       
          #               yr:            row[4].strip,           # year        
          #               cat:        models[row[2]][2],      # category    
          #               e:    endorsements,           # endorsements
          #               a:         "#{row['CITY'].strip}, #{row['STATE'].strip}".strip
          #             }
          new_plane = { t: row[0].strip,           # tail_number 
                        i: "#{models[row[2]][0]},#{models[row[2]][1]},#{row[4].strip},#{models[row[2]][2]},#{endorsements},#{row['CITY'].strip}, #{row['STATE'].strip}"
                      }
          json.puts new_plane.to_json
          
                      # new_plane = [ row[0].strip,           # tail_number 
                      #                 models[row[2]][0],      # make        
                      #                 models[row[2]][1],      # model       
                      #                 row[4].strip,           # year        
                      #                 models[row[2]][2],      # category    
                      #                 endorsements,           # endorsements
                      #                 "#{row['CITY'].strip}, #{row['STATE'].strip}".strip
                      #               ]
                      
        end
        
      end
    end
    
  end
  
  def classification(type, category)
    return 0 if type==="4" and category==="1"
    return 1 if type==="4" and category==="2"
    return 2 if type==="5" and category==="1"
    return 3 if type==="5" and category==="2"
    return 4 if type==="6"
    return nil
    # return "Airplane Single-Engine Land" if type==="4" and category==="1"
    # return "Airplane Single-Engine Sea" if type==="4" and category==="2"
    # return "Airplane Multi-Engine Land" if type==="5" and category==="1"
    # return "Airplane Multi-Engine Sea" if type==="5" and category==="2"
    # return "Helicopter" if type==="6"
    # return ""
  end
  
end

task :greet do
  puts "hello world"
end
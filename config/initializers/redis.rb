# redis_url = ENV['MYREDIS_URL'] || 'redis://localhost:6379'
# $redis = Redis.new url: redis_url  
# 
# 

uri = URI.parse(ENV["REDISTOGO_URL"])
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Geocoder.configure(cache: $redis)

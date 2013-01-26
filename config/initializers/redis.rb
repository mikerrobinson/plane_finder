redis_url = ENV['MYREDIS_URL'] || 'redis://localhost:6379'
$redis = Redis.new url: redis_url  
Geocoder.configure(cache: $redis)

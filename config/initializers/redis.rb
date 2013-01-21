$redis = Redis.new(host: 'localhost', port: 6379)
Geocoder.configure(cache: $redis)
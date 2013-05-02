if (ENV['REDISTOGO_URL'])
  uri = URI.parse(ENV['REDISTOGO_URL'])

  REDIS = Redis.new(:host => uri.host, :user => uri.user, :port => uri.port, :password => uri.password)
else
  REDIS = MockRedis.new
end

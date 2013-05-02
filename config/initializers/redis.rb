if (ENV['REDISTOGO_URL'])
  uri = URI.parse(ENV['REDISTOGO_URL'])
  Rails.logger.info ENV['REDISTOGO_URL']
  Rails.logger.info uri

  REDIS = Redis.new(host => uri.host, :port => uri.port, :password => uri.password)
else
  REDIS = MockRedis.new
end

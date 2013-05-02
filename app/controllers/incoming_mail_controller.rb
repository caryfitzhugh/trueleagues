class IncomingMailController < ApplicationController
  INBOUND_HASH='e41ebe676cd28e89344c9eba5f5baeed'
  REDIS_KEY= 'trueleagues:incoming_emails'

  def ingest
    message = request.body.read

    Rails.logger.info "Receiving message: #{message}"

    REDIS.lpush(REDIS_KEY, message)
    REDIS.ltrim(REDIS_KEY, 0, 50)

    head :accepted
  end

  def index
    @messages = REDIS.lrange(REDIS_KEY, 0, -1).map {|m| OpenStruct.new(JSON.parse(m)) }
  end
end

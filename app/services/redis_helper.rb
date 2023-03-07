# Simple wrapper for Redis - to use shared connections
# List of redis commands: https://redis.io/commands/'
# Usage:
#   RedisHelper.get('some-key')
#   RedisHelper.put('some-key', 'some-value')
class RedisHelper
  class << self
    def method_missing(cmd, *args, &block)
      runcmd(cmd, *args)
    end

    def exists?(key)
      runcmd(:exists, key)
    end

    def runcmd(cmd, *args)
      redis.send(cmd, *args)
    end

    def redis
      # NOTE: Redis.current is no longer allowed see this:
      # https://stackoverflow.com/questions/21075781/redis-global-variable-with-ruby-on-rails/34673035#34673035
      # Since this is just a test app I'm going to ignore this for now
      # Redis.current deprecated
      # Redis.current.with do |rconn|
      #  rconn.send(cmd, *args)
      # end
      Redis.new(url: url)
    end

    def url
      ENV['REDIS_URL'] || 'redis://host.docker.internal:6379'
    end
  end
end

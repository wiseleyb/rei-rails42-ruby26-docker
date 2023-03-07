Sidekiq.configure_client do |config|
  config.redis = { url: RedisHelper.url }
end

Sidekiq.configure_server do |config|
  config.redis = { url: RedisHelper.url }
end

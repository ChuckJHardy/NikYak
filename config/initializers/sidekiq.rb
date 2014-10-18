Sidekiq.configure_client do |config|
  config.redis = { size: 1 }
end

Sidekiq.configure_server do |config|
  ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])
  config.redis = { size: 9, url: ENV["REDIS"] }
end


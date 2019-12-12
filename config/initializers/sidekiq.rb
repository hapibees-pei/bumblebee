if Rails.env.development?
  Sidekiq.configure_server do |config|
    config.redis = { url: "redis://localhost:6380" }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: "redis://localhost:6380" }
  end
end

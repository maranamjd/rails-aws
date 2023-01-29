# frozen_string_literal: true
if Rails.env.development? && ENV["SIDEKIQ_ON"].blank?
  require "sidekiq/testing"
  Sidekiq::Testing.inline!
else
  config_params = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379") }
  passkey = Rails.application.credentials.dig(:production, :redis_password)
  config_params[:password] = passkey if passkey.present?

  Sidekiq.configure_server do |config|
    config.redis = config_params
  end

  Sidekiq.configure_client do |config|
    config.redis = config_params
  end
end
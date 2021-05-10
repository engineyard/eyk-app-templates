require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    unless Rails.env.production?
      # Mock redis in non-production environments
      $redis = MockRedis.new
    else 
      # Only use actual Redis in production
      $redis = Redis.new
    end
    $rollout = Rollout.new($redis, logging: { history_length: 100, global: true })
    Rollout::UI.configure do
      instance { $rollout }
    end

    LightService::Configuration.logger = Logger.new(STDOUT)
  end
end

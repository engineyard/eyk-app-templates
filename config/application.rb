require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.active_job.queue_adapter = :sidekiq 

    # AppMap
    #
    # application.rb is a good place to do this, along with all the other railties.
    # Don't require the railtie in environments that don't bundle the appmap gem.
    require 'appmap/railtie' if defined?(AppMap)
    config.appmap.enabled = true if ENV['APPMAP_RECORD']

    # Rollout
    #
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
  end
end

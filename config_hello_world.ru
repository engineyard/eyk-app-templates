require 'action_controller/railtie'

class HelloWorldApp < Rails::Application
  config.eager_load = true # necessary to silence warning
  config.logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
  config.secret_key_base = SecureRandom.uuid    # Rails won't start without this
  config.action_dispatch.default_headers = { 'X-Frame-Options' => 'ALLOWALL' }
  routes.append { root :to => "hello#index" }
end

class HelloController < ActionController::Base
  def index
    render html: hello_html.html_safe
  end
  
  def hello_html
    html = <<-HELLO_HTML
    <h3>This is a simple one-line Rails application</h3>
    It is only meant as a placeholder.
    Copy your Rails app files into this project and deploy to EYK.
    HELLO_HTML

    html
  end
end

HelloWorldApp.initialize!
run HelloWorldApp

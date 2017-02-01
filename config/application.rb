require_relative 'boot'

require "rails"

%w(
  action_controller/railtie
  action_view/railtie
  action_mailer/railtie
  active_job/railtie
  action_cable/engine
  rails/test_unit/railtie
  sprockets/railtie
).each do |railtie|
  begin
    require "#{railtie}"
  rescue LoadError
  end
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BtcPostsParser
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    Koala.config.api_version = 'v2.0'
    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('lib/parsers')
  end
end

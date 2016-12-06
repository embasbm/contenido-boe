require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module ContenidoBoe
  # ContenidoBoe Application class
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/services)
    config.mongoid.logger = Logger.new($stdout, :warn)
    config.generators do |g|
      g.orm :mongoid
    end
  end
end

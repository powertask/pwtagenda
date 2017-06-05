require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pwtagenda
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1


    config.time_zone = 'Brasilia'

    config.autoload_paths += %W[#{config.root}/lib]

    config.i18n.load_path += Dir[Rails.root.join("config/locales/**.*.yml").to_s]
    config.i18n.default_locale = :"pt-BR"
    config.i18n.enforce_available_locales = false

    config.encoding = "utf-8"

    config.filter_parameters += [:password]

    config.active_support.escape_html_entities_in_json = true

    config.generators.test_framework :rspec, :fixtures => false
    config.generators.assets = false

    config.active_record.time_zone_aware_types = [:datetime, :time]
    config.active_record.belongs_to_required_by_default = false

    config.assets.enabled = true
    config.assets.version = '1.0'
    config.serve_static_assets = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

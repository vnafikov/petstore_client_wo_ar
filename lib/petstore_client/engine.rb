require 'rails'

module PetstoreClient
  class Engine < Rails::Engine
    isolate_namespace PetstoreClient

    initializer :petstore_client do
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.acronym 'HTTP'
      end
    end

    initializer :petstore_client_config, after: :load_config_initializers do |app|
      app.config.app = {} unless app.config.respond_to?(:app)
      app.config.app[:petstore_client] ||= {}
      app.config.app[:petstore_client].reverse_update(
        api_key: 'token'
      ) # TODO: deep_reverse_update.
    end
  end
end

module PetstoreClient
  module Resources
    class Base
      def initialize(client:)
        @client = client
      end

      def get(endpoint = nil, parameters = {})
        if endpoint && endpoint.is_a?(Symbol)
          raise ArgumentError, 'Unknown Petstore API endpoint.' if self.class::ENDPOINTS.exclude?(endpoint)

          return send(endpoint, parameters)
        end

        default_get(parameters.presence || endpoint)
      end
    end
  end
end

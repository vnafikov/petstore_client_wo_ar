module PetstoreClient
  module Resources
    class Pet < Base
      ENDPOINTS = [:find_by_status].freeze
      STATUS_VALUES = %i[available pending sold].freeze

      private

      def default_get(parameters)
        id = parameters.fetch(:id)
        endpoint = "pet/#{id}"
        @client.call(request_method: Methods::GET, endpoint: endpoint)
      end

      def find_by_status(parameters = {})
        status = parameters.fetch(:status, STATUS_VALUES)
        query_values = URI.encode_www_form(status: status)
        endpoint = "pet/findByStatus?#{query_values}"
        @client.call(request_method: Methods::GET, endpoint: endpoint)
      end
    end
  end
end

module PetstoreClient
  module Exceptions
    class ResponseError < ClientError
      attr_reader :response

      def initialize(response)
        @response = response
      end

      def to_s
        super + format(' (%<data>s)', data: data.map { |k, v| %(#{k}: "#{v}") }.join(', '))
      end

      def error_code
        data[:code] || data['code']
      end

      private

      def data
        @data ||= begin
          JSON.parse(response.body)
        rescue JSON::ParserError
          {code: response.code}
        end.merge!(uri: response.uri.to_s)
      end
    end
  end
end

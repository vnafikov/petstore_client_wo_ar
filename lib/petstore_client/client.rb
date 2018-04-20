require 'net/http'

module PetstoreClient
  class Client
    API_URL = 'http://petstore.swagger.io/v2/'.freeze
    RESOURCES = ['pet'].freeze
    TIMEOUT = 15.seconds

    RESOURCES.each do |resource|
      define_method(resource) do
        "petstore_client/resources/#{resource}".classify.constantize.new(client: self)
      end
    end

    def initialize(api_key: PetstoreClient[:api_key])
      @api_key = api_key
    end

    def call(request_method:, endpoint:, parameters: nil)
      uri = URI("#{API_URL}#{endpoint}")
      response = request(request_method, uri, parameters)

      unless response.is_a?(Net::HTTPSuccess)
        raise Exceptions::ResponseError.new(response), 'Petstore API has returned an error.'
      end
      JSON.parse(response.body) if response.body.present?
    end

    private

    def request(request_method, uri, parameters)
      request = "net/http/#{request_method}".classify.constantize.new(uri)
      request.content_type = 'application/json'
      request['X-API-Key'] = @api_key
      request.body = parameters.to_json if parameters.present?

      Net::HTTP.start(uri.hostname, uri.port, read_timeout: TIMEOUT) { |http| http.request(request) }
    end
  end
end

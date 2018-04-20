require 'petstore_client/version'
require 'petstore_client/engine'
require 'petstore_client/exceptions'
require 'petstore_client/client'
require 'petstore_client/methods'
require 'petstore_client/resources'

module PetstoreClient
  extend SingleForwardable

  def_delegators 'Rails.configuration.app[:petstore_client]', :[], :[]=, :fetch
end

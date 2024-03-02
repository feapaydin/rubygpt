# frozen_string_literal: true

module Rubygpt
  module Response
    class ConnectionReturnNotStandardizedError < StandardError; end

    # Unifies responses from all connection/adapter objects.
    #  This is required since a response from Faraday will not be the same as a response from another adapter
    #  that might be introduced in the future. To solve this,
    #  we're overriding the post, get, put, delete methods in connection objects to return a StandardApiResponse
    class StandardApiResponse
      # The HTTP package contents of the response
      attr_reader :status, :body, :headers

      # The original, non-standardized response object received from the adapter
      # This is useful for debugging and for accessing adapter-specific features
      attr_reader :adapter_response

      # @param [Integer] status The HTTP status code
      # @param [Hash] body The response body
      # @param [Hash] headers The response headers
      # @param [Object] adapter_response The original, non-standardized response object received from the adapter
      def initialize(status:, body:, headers:, adapter_response: nil)
        @status = status
        @body = body
        @headers = headers
        @adapter_response = adapter_response
      end
    end

    # Base class for all API response objects
    class BaseResponse
      # The response from the API, standardized by the connection object
      attr_reader :api_response

      # @param [StandardApiResponse] api_response The response from the API, standardized by the connection object
      def initialize(api_response)
        raise ConnectionReturnNotStandardizedError unless api_response.is_a?(StandardApiResponse)

        @api_response = api_response
        build_attributes_from_body
      end

      private

      # Builds instance variables dynamically from the response body
      def build_attributes_from_body
        @api_response.body&.each do |key, value|
          variable_name = key.to_s.downcase
          instance_variable_set("@#{variable_name}", value)
          self.class.send(:attr_reader, variable_name)
        end
      end
    end
  end
end

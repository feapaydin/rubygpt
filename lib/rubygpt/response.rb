# frozen_string_literal: true

module Rubygpt
  module Response
    class ConnectionReturnNotStandardizedError < StandardError; end

    # Unifies responses from all connection/adapter objects.
    #  This is required since a response from Faraday will not be the same as a response from another adapter
    #  that might be introduced in the future. To solve this,
    #  we're overriding the post, get, put, delete methods in connection objects to return a StandardApiResponse
    class StandardApiResponse
      attr_reader :status, :body, :headers, :adapter_response

      def initialize(status:, body:, headers:, adapter_response: nil)
        @status = status
        @body = body
        @headers = headers
        @adapter_response = adapter_response
      end
    end

    # Base class for all API response handlers
    class BaseResponse
      attr_reader :standard_response

      def initialize(standard_response)
        raise ConnectionReturnNotStandardizedError unless standard_response.is_a?(StandardApiResponse)

        @standard_response = standard_response
      end
    end
  end
end

# frozen_string_literal: true

require "faraday"

module Rubygpt
  module Connection
    # The HTTP connection adapter derived from Faraday::Connection
    class Faraday < Faraday::Connection
      # Initializes a new connection object
      #
      # @param [Configuration] configuration
      # @param [Hash] faraday_options
      def initialize(configuration, faraday_options = {})
        options = { url: configuration.api_url, headers: configuration.to_headers }.merge(faraday_options)
        super(options) do |faraday|
          faraday.request :json
          faraday.response :json
          faraday.response :raise_error
        end
      end

      def post(*args)
        faraday_response = super(*args)
        Rubygpt::Response::StandardApiResponse.new(
          adapter_response: faraday_response,
          status: faraday_response.status,
          body: faraday_response.body,
          headers: faraday_response.headers
        )
      end
    end
  end
end

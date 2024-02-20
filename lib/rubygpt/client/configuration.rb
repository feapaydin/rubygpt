# frozen_string_literal: true

module Rubygpt
  module Client
    class Configuration
      class InvalidConfigurationError < StandardError; end

      # The API URL to use for the client
      attr_reader :api_url

      # The API key to use for the client
      attr_reader :api_key

      # The OpenAI OrganizationID that will be sent when making requests (optional)
      # https://platform.openai.com/docs/api-reference/organization-optional
      attr_reader :organization_id

      # The base URL for the OpenAI API
      DEFAULT_API_URL = "https://api.openai.com/v1"

      def initialize(options = {})
        @api_url = options[:api_url] || DEFAULT_API_URL
        @api_key = options[:api_key] || raise(InvalidConfigurationError, "api_key is required")
        @organization_id = options[:organization_id]
      end

      def to_headers
        {
          'Authorization' => "Bearer #{api_key}",
          'Organization' => organization_id
        }.compact
      end
    end
  end
end
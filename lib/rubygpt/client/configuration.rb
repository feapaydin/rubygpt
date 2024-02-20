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

      # The GPT model to use for the client
      # Sample values: gpt-4, gpt-4-turbo-preview, gpt-3.5-turbo, gpt-3.5-turbo-instruct
      # Refer to https://platform.openai.com/docs/models
      attr_reader :model

      # The base URL for the OpenAI API
      DEFAULT_API_URL = "https://api.openai.com/v1"

      # Initializes new Rubygpt::Client::Configuration object
      #
      # @param [Hash] options
      # @option options [String] :api_url required
      # @option options [String] :api_key
      # @option options [String] :organization_id
      # @option options [String] :model required
      def initialize(options = {})
        @model = options[:model] || raise(InvalidConfigurationError, "model is required")
        @api_key = options[:api_key] || raise(InvalidConfigurationError, "api_key is required")
        @api_url = options[:api_url] || DEFAULT_API_URL
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
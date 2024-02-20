# frozen_string_literal: true

module Rubygpt
  class Client
    # Handles the configuration options when initializing a new Rubygpt::Client object
    class Configuration
      # Initializes a new Rubygpt::Client::Configuration object from a hash or another Configuration object
      def self.from(configuration_input)
        case configuration_input
        when Configuration then configuration_input
        when Hash, nil then Configuration.new(configuration_input || {})
        else raise InvalidConfigurationError, "Invalid configuration provided for client."
        end
      end

      class InvalidConfigurationError < StandardError; end

      # The API URL to use for the client
      attr_accessor :api_url

      # The API key to use for the client
      attr_accessor :api_key

      # The OpenAI OrganizationID that will be sent when making requests (optional)
      # https://platform.openai.com/docs/api-reference/organization-optional
      attr_accessor :organization_id

      # The GPT model to use for the client
      # Sample values: gpt-4, gpt-4-turbo-preview, gpt-3.5-turbo, gpt-3.5-turbo-instruct
      # Refer to https://platform.openai.com/docs/models
      attr_accessor :model

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
        @model = options[:model]
        @api_key = options[:api_key]
        @api_url = options[:api_url] || DEFAULT_API_URL
        @organization_id = options[:organization_id]
      end

      def validate!
        raise(InvalidConfigurationError, "model is required") unless model
        raise(InvalidConfigurationError, "api_key is required") unless api_key
      end

      def to_headers
        {
          "Authorization" => "Bearer #{api_key}",
          "OpenAI-Organization" => organization_id
        }.compact
      end
    end
  end
end

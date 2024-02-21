# frozen_string_literal: true

module Rubygpt
  # Moderates available connection adapters
  module Connection
    class << self
      # Find and initialize the connection adapter
      #
      # @param [Configuration] configuration
      # @param [Hash] options
      def new(configuration, options = {})
        const_get(configuration.connection_adapter.to_s.capitalize).new(configuration, options)
      rescue NameError
        raise Client::Configuration::InvalidConfigurationError, "Invalid adapter provided for connection."
      end
    end
  end
end

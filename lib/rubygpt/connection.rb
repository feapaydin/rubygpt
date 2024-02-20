# frozen_string_literal: true

module Rubygpt
  # Moderates available connection adapters
  module Connection
    class << self
      # Find and initialize the connection adapter
      #
      # @param [Configuration] configuration
      # @param [Hash] options
      def new(configuration, options = {}, &block)
        klass = const_get(configuration.connection_adapter.to_s.capitalize)
        raise Client::Configuration::InvalidConfigurationError, "Invalid adapter provided for connection." unless klass

        klass.new(configuration, options, &block)
      end
    end
  end
end

# frozen_string_literal: true

module Rubygpt
  # Main class that issues the connection to OpenAI APIs
  class Client
    # The configuration object for the client
    attr_accessor :configuration

    # Initializes new Rubygpt::Client object
    #
    # @param [Hash] configuration
    # @param [Configuration] configuration
    def initialize(configuration = nil)
      @configuration = Configuration.from(configuration)
      yield @configuration if block_given?
      @configuration.validate!
    end
  end
end

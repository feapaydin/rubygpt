# frozen_string_literal: true

module Rubygpt
  # Main class that issues the connection to OpenAI APIs
  class Client
    # Initializes new Rubygpt::Client object
    #
    # @param [Hash] configuration
    # @param [Configuration] configuration
    def initialize(configuration)
      @configuration = Configuration.from(configuration)
      yield @configuration if block_given?
    end
  end
end

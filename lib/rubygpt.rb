# frozen_string_literal: true

require_relative "rubygpt/version"
require_relative "rubygpt/connection/faraday"
require_relative "rubygpt/connection"
require_relative "rubygpt/client/configuration"
require_relative "rubygpt/client"
require_relative "rubygpt/common/message"
require_relative "rubygpt/response"
require_relative "rubygpt/response/chat_completion"
require_relative "rubygpt/requester"
require_relative "rubygpt/requester/chat_requester"

# The main module for Rubygpt
# Contains static methods for configuration
module Rubygpt
  class << self
    # The default singleton client for the module
    # Allows a global configuration to be set across the module
    #
    # @return [Client]
    def configure(configuration = nil, &block)
      reset_requesters
      @default_client = Client.new(configuration, &block)
    end

    # A ChatRequester object, configured by default client
    # Allows the Rubygpt.chat calls
    #
    # @return [Requester::ChatRequester]
    def chat
      @chat ||= Requester::ChatRequester.new(@default_client)
    end

    # Remove memoized requester objects to allow reallocation
    def reset_requesters
      @chat = nil
    end
  end
end

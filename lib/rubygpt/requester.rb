# frozen_string_literal: true

module Rubygpt
  module Requester
    # Base module for all requester modules
    class BaseRequester
      # The client object that will be used to make the request
      attr_reader :client

      # The API endpoint for the request
      attr_reader :api_endpoint

      # The response handler class that will be initialized with the response
      attr_reader :response_handler

      # Initializes new Rubygpt::Requester object
      #
      # @param [Client] client
      def initialize(client)
        @client = client
      end

      # Performs a POST request to the API endpoint
      def create
        raise NotImplementedError
      end
    end
  end
end

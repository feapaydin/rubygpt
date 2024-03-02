# frozen_string_literal: true

module Rubygpt
  module Requester
    # Performs CRUD operations for OpenAI Chat Completion Objects
    # https://platform.openai.com/docs/api-reference/chat
    class ChatRequester < BaseRequester
      # Initializes the ChatRequester
      #
      # @param [Client] client The client object
      def initialize(client)
        @api_endpoint = "chat/completions"
        super(client)
      end

      # Performs a POST request to the API endpoint
      # https://platform.openai.com/docs/api-reference/chat/create
      #
      # @param [String] args The single message to send. Message will be sent with system role
      # @param [Array] args The array of messages to send. Each message can be a string or a hash
      # @param [Hash] args The arguments for the request body, including messages
      # @option args [Array] :messages The messages to send
      #
      # @return [Response::ChatCompletion]
      def create(args = {})
        Response::ChatCompletion.new client.post(api_endpoint, create_request_body(args))
      end

      private

      # Builds the request body for the POST request
      def create_request_body(args)
        request_body_params = args.is_a?(Hash) ? args.except(:messages) : {}
        {
          model: client.configuration.model,
          messages: messages_from_args(args)
        }.merge(request_body_params).compact
      end

      # Handles the messages: data provided in the args
      def messages_from_args(args)
        case args
        when String then [Common::Message.new(args).to_h]
        when Array then args.map { |message| Common::Message.new(message).to_h }
        when Hash
          return [Common::Message.new(args).to_h] unless args.key?(:messages)

          args[:messages].map { |message| Common::Message.new(message).to_h }
        else raise ArgumentError, "Invalid message data provided"
        end
      end
    end
  end
end

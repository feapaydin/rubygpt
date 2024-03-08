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
        # TODO: handle args[:stream] for streaming completions
        Response::ChatCompletion.new client.post(api_endpoint, create_request_body(args))
      end

      private

      # Builds the request body for the POST request
      def create_request_body(args)
        request_body = { model: client.configuration.model }
        if args.is_a?(Hash)
          # Allowing JSON mode for the request
          # https://platform.openai.com/docs/guides/text-generation/json-mode
          request_body[:response_format] = { type: "json_object" } if args[:json]
          request_body[:messages] = messages_from_hash(args)
          request_body.merge! args.except(:messages, :json, *Common::Message::MESSAGE_REQUEST_KEYS)
        else
          request_body[:messages] = messages_from_args(args)
        end
        request_body.compact
      end

      # Handles the message data provided as arguments
      def messages_from_args(args)
        messages =
          case args
          when String then [Common::Message.new(args)]
          when Array then args.map { |message| Common::Message.new(message) }
          else raise ArgumentError, "Invalid message data provided"
          end
        map_messages(messages)
      end

      # Handles the message data provided as a hash
      def messages_from_hash(hash)
        messages =
          if hash.key?(:messages)
            # If it is a hash with a :messages key, then it's a request config with messages provided explicitly
            # { messages: [{ content: 'foo', role: 'user' }, { content: 'bar', role: 'system' }] }
            hash[:messages].map { |message| Common::Message.new(message) }
          else
            # If it is a hash without a :messages key, then it's a message config itself
            # { content: 'foo', role: 'user' }
            [Common::Message.new(hash)]
          end
        map_messages(messages)
      end

      # Maps the messages to a hash
      # Validates the messages and raises an error if no messages are provided
      def map_messages(messages)
        messages.map do |message|
          raise ArgumentError, "Empty message contents found." if message.empty?

          message.to_h
        end
      end
    end
  end
end

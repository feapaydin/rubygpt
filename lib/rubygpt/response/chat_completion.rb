# frozen_string_literal: true

module Rubygpt
  module Response
    # Represents the ChatCompletion response from the Chat API
    # https://platform.openai.com/docs/api-reference/chat/object
    class ChatCompletion < BaseResponse
      # Represents a Choice object in the ChatCompletion response
      class Choice
        # The index of the choice in the list of choices.
        attr_reader :index

        # A chat completion message generated by the model.
        # A Message object
        attr_reader :message

        # Log probability information for the choice.
        attr_reader :logprobs

        # The reason the model stopped generating tokens.
        # One of: stop, length, content_filter, tool_calls
        attr_reader :finish_reason

        # Initializes the Choice object
        def initialize(index:, message:, logprobs:, finish_reason:)
          @index = index
          @message = Common::Message.new(**message.transform_keys(&:to_sym))
          @logprobs = logprobs
          @finish_reason = finish_reason
        end

        # Delegations to the message object
        def content
          message.content
        end

        def role
          message.role
        end

        # Returns true if the choice failed to generate a complete message
        def failed?
          finish_reason != "stop"
        end

        def to_h
          { index:, message: message.to_h, logprobs:, finish_reason: }.compact
        end
      end

      # Initializes the ChatCompletion object
      #
      # @param [StandardApiResponse] api_response The response from the API, standardized by the connection object
      def initialize(api_response)
        super
        @choices = @choices.map { |choice| Choice.new(**choice.transform_keys(&:to_sym)) }.sort_by(&:index) if @choices
      end

      # The list of message strings generated by the model.
      #
      # return [Array<String>]
      def messages
        @messages ||= choices.map { |choice| choice.message.content }
      end

      # Messages combined into a single string, separated by newlines
      def read(message_separator: "\n")
        @read ||= messages.join(message_separator)
      end

      def failed?
        choices.any?(&:failed?)
      end

      def cost
        usage["total_tokens"] || usage[:total_tokens]
      end

      def to_h
        { id:, object:, created:, model:, system_fingerprint:, usage:, choices: choices.map(&:to_h) }.compact
      end
    end
  end
end

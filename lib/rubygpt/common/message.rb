# frozen_string_literal: true

module Common
  # Represents a Message object that is used in OpenAI Chat API requests
  class Message
    # The role of the author of this message.
    attr_reader :role

    # The contents of the message.
    attr_reader :content

    # Provides the model information to differentiate between participants of the same role.
    attr_reader :name

    # The tool calls generated by the model, such as function calls. (assistant msg only)
    attr_reader :tool_calls

    # Tool call that this message is responding to. (tool msg only)
    attr_reader :tool_call_id

    # Initializes the Message object
    #
    # @param [String, Hash] options The message content
    def initialize(options = {})
      if options.is_a?(String)
        @role = "system"
        @content = options
      else
        @role = options[:role] || "system"
        @content = options[:content]
        @name = options[:name]
        @tool_calls = options[:tool_calls]
        @tool_call_id = options[:tool_call_id]
      end
    end

    def to_h
      { role:, content:, name:, tool_calls:, tool_call_id: }.compact
    end
  end
end

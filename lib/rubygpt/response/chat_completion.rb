# frozen_string_literal: true

module Rubygpt
  module Response
    # Represents the response from the Chat API
    class ChatCompletion < BaseResponse
      attr_reader :id, :object, :create, :mode, :system_fingerprint, :choice, :usage

      def initialize(standard_response)
        super(standard_response)
        @id = body["id"]
        @object = body["object"]
        @create = body["create"]
        @mode = body["mode"]
        @system_fingerprint = body["system_fingerprint"]
        @choices = body["choices"]
        @usage = body["usage"]
      end
    end
  end
end

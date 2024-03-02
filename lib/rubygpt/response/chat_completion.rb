# frozen_string_literal: true

module Rubygpt
  module Response
    # Represents the ChatCompletion response from the Chat API
    # https://platform.openai.com/docs/api-reference/chat/object
    class ChatCompletion < BaseResponse
      def initialize(api_response)
        super
        build_choices_from_body
      end

      private

      def build_choices_from_body
        # TODO: Build choice objects using api_response.body.choices
        {}
      end
    end
  end
end

# frozen_string_literal: true

module Rubygpt
  module Response
    # Base class for all API response handlers
    class BaseResponse
      attr_reader :content

      def initialize(content)
        @content = content
      end
    end
  end
end

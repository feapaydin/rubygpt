# frozen_string_literal: true

module Rubygpt
  module Response
    # Base class for all API response handlers
    class BaseResponse
      def initialize(response)
        @response = response
      end
    end
  end
end

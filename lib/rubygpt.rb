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

module Rubygpt
  class Error < StandardError; end
end

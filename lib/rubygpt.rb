# frozen_string_literal: true

require_relative "rubygpt/version"
require_relative "rubygpt/connection/faraday"
require_relative "rubygpt/connection"
require_relative "rubygpt/client/configuration"
require_relative "rubygpt/client"

module Rubygpt
  class Error < StandardError; end
end

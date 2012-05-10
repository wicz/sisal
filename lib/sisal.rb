require_relative "sisal/message"
require_relative "sisal/response"
require_relative "sisal/provider"
require_relative "sisal/messenger"
require_relative "sisal/configuration"

module Sisal
  extend self

  attr_writer :configuration

  def configuration
    @configuration ||= Configuration.new
  end
end

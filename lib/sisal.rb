require_relative 'sisal/message'
require_relative 'sisal/response'
require_relative 'sisal/provider'
require_relative 'sisal/messenger'
require_relative 'sisal/configuration'

require_relative 'sisal/providers/tropo_provider'
require_relative 'sisal/providers/clickatell_provider'
require_relative 'sisal/providers/twilio_provider'

module Sisal
  extend self

  attr_writer :configuration

  def configuration
    @configuration ||= Configuration.new
  end
end
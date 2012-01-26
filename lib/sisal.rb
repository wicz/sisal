require_relative 'sisal/message'
require_relative 'sisal/response'
require_relative 'sisal/provider'
require_relative 'sisal/messenger'

require_relative 'sisal/providers/tropo_provider'
require_relative 'sisal/providers/clickatell_provider'
require_relative 'sisal/providers/twilio_provider'

module Sisal
  extend self

  attr_accessor :default_provider

  def configure(&block)
    instance_eval(&block)
  end

  def reset
    instance_eval do
      default_provider = nil
      @providers = {}
    end
  end

  def providers
    @providers ||= {}
  end

  def provider(name, options)
    provider_class = Sisal::Providers.const_get("#{name.capitalize}Provider")
    providers[name.to_s] = provider_class.new(options)
  end
end
module Sisal
  class Configuration
    attr_accessor :providers
    attr_writer :default_provider

    def initialize
      @providers = {}
    end

    def provider(name, provider_object = nil)
      name = name.to_s
      @providers[name] = provider_object if provider_object
      yield(@providers[name]) if block_given?
      @providers[name]
    end

    def default_provider
      @providers[@default_provider.to_s]
    end
  end
end

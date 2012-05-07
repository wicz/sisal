module Sisal
  class Messenger
    UnknownProvider = Class.new(StandardError)

    def send(message, options = {})
      provider_name = options[:provider].to_s
      provider = Sisal.configuration.providers[provider_name] || Sisal.configuration.default_provider
      raise UnknownProvider unless provider
      provider.send(message, options)
    end
  end
end

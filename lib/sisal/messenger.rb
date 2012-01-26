module Sisal
  class Messenger
    UnknownProvider = Class.new(StandardError)

    def send(message, options = {})
      provider_name = options[:provider] || Sisal.default_provider
      provider = Sisal.providers[provider_name.to_s]
      raise UnknownProvider unless provider
      provider.send(message)
    end
  end
end
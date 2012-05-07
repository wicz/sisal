module Sisal
  class Provider
    def send(message, options = {})
      raise "Provider#send must be implemented in children classes"
    end
  end
end

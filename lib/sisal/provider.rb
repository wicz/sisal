module Sisal
  class Provider
    def send(message)
      responses = []
      message.valid?
      message.to.each do |to|
        responses << deliver(to, message)
      end
      responses
    end

    def deliver(to, message)
      raise "Provider#deliver must be implemented in children classes"
    end
  end
end
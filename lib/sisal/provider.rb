module Sisal
  class Provider

    def send message
      responses = []
      message.valid?
      message.to.each do |dst|
        message.data.each do |part|
          responses << deliver(dst, part)
        end
      end
      responses
    end

    def deliver(number, message)
      raise "Provider#deliver must be implemented in children classes"
    end
  end
end
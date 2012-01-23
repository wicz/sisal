module Sisal
  class Provider

    def send message
      responses = []
      message.valid?
      formatter = Sisal::Formatters::EMS::Text.new(message)
      message.to.each do |dst|
        formatter.data.each do |data|
          responses << deliver(dst, data)
        end
      end
      responses
    end

    def deliver(number, message)
      raise "Provider#deliver must be implemented in children classes"
    end
  end
end
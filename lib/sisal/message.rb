module Sisal
  class Message
    InvalidPhoneNumber  = Class.new(StandardError)

    PHONE_REGEX       = /^\d+$/
    PHONE_LENGTH      = [4, 15]

    attr_accessor :to, :text

    def initialize(to, text)
      @to, @text = to, text
    end

    def valid?
      validate_number
    end

    private

    def validate_number
      to.length.between?(*PHONE_LENGTH) && to.match(PHONE_REGEX) or
      raise InvalidPhoneNumber.new(to)
    end
  end
end

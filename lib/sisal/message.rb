module Sisal
  class Message
    InvalidPhoneNumber  = Class.new(StandardError)
    MessageTooLarge     = Class.new(StandardError)
    InvalidEncoding     = Class.new(StandardError)

    PHONE_REGEX       = /^\d+$/
    PHONE_LENGTH      = [4, 15]
    SMS_MAX_SIZE      = 140

    attr_accessor :to, :text

    def initialize(to, text)
      @to, @text = to, text
    end

    def text
      @text.encode('US-ASCII')
    end

    def valid?
      validate_numbers
      validate_encoding
      validate_message_size
    end

    def validate_numbers
      to.each { |number| valid_number? number }
    end

    def valid_number?(number)
      number.length.between?(*PHONE_LENGTH) && number.match(PHONE_REGEX) or
      raise InvalidPhoneNumber.new(number)
    end

    def validate_message_size
      raise MessageTooLarge unless @text.bytesize <= SMS_MAX_SIZE
    end

    def validate_encoding
      raise InvalidEncoding unless @text.encoding.ascii_compatible?
    end
  end
end

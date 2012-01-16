module Sisal
  class Message
    InvalidPhoneNumber  = Class.new(StandardError)
    InvalidSenderId     = Class.new(StandardError)
    MessageTooLarge     = Class.new(StandardError)

    PHONE_REGEX       = "^\d$"
    PHONE_LENGTH      = [10, 15]
    SENDER_ID_REGEX   = "^[0-9a-z]+$"
    SENDER_ID_LENGTH  = [0, 8]
    SMS_MAX_SIZE      = 140 # octets

    # From and To phone numbers must have from 10 to 15 digits
    attr_accessor :from, :to

    # The content. Can be text or binary (image, ringtone, vcard)
    attr_writer :data

    # Some provider support Sender IDs
    attr_accessor :sender_id

    # These IDs are used to track the message
    # client is set by us, provider by them
    attr_accessor :client_id, :provider_id

    # Flash SMS
    attr_accessor :flash

    # Maximum number of parts when splitting a concatenated SMS
    # Value 0 disables this function and message won't be splitted
    # http://en.wikipedia.org/wiki/Concatenated_SMS
    attr_writer :split

    # Messages can be of type text or binary
    attr_reader :type

    # SMS can be encoded using GSM 7-bit, ISO/IEC 8859 8-bit and
    # Unicode UTF-16. Type binary must use 8-bit
    attr_accessor :encoding

    def initialize(to, message)
      @to, @data = to, message
      @encoding = Sisal::Encodings::GsmEncoding.new
    end

    def encoded
      @encoding.encode(@data)
    end

    # Data is handled according to message type.
    # Binary will be encoded and splitted.
    def data
      [*@data]
    end

    def to
      [*@to]
    end

    def valid?
      validate_numbers
      validate_sender_id
      validate_message_size
    end

    def validate_numbers
      [@to].each { |number| valid_number? number }
    end

    def valid_number?(number)
      raise InvalidPhoneNumber unless number.length.between?(*PHONE_LENGTH)# && number.match /PHONE_REGEX/
    end

    def validate_sender_id
      return unless sender_id
      raise InvalidSenderId unless @sender_id.length.between?(*SENDER_ID_LENGTH)# && @sender_id.match /SENDER_ID_REGEX/i
    end

    def validate_message_size
      raise MessageTooLarge unless (@data.bytesize <= SMS_MAX_SIZE)
    end
  end
end
module Sisal
  module Formatters
    module EMS
      class Text

        UDHL  = "05" # UDH Length
        IEI   = "00" # Information Element Identifier
        IEDL  = "03" # Information Element Data Length

        def initialize(message)
          @message = message
          @payload = message.encoded
          split_short_messages
          set_udh
        end

        def set_udh
          sms_id = sprintf('%02X', rand(255))
          @udh = UDHL + IEI + IEDL + sms_id + sprintf('%02X', @short_messages.size)
        end

        def split_short_messages
          max_size = (@message.encoding.name == :latin) ? 134 : 67
          @short_messages = @payload.scan(/.{0,268}/).select { |str| str.length > 0 }
        end

        def data
          parts = []
          @short_messages.each_with_index do |sm|
            udh = @udh + sprintf('%02d', parts.size+1)
            parts << {udh: udh, data: sm}
          end
          parts
        end

      end
    end
  end
end
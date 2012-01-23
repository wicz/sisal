module Sisal
  module Encodings
    class UnicodeEncoding

      def name
        :unicode
      end

      def encode(str)
        str.encode('UTF-16BE').bytes.map { |b| sprintf('%02X', b) }.join
      end

    end
  end
end
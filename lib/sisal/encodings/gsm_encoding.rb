module Sisal
  module Encodings
    class GsmEncoding

      def name
        :gsm
      end

      def encode(str)
        str.encode('US-ASCII').bytes.map { |b| sprintf('%X', b) }.join
      end

    end
  end
end
module Sisal
  module Encodings
    class LatinEncoding

      def name
        :latin
      end

      def encode(str)
        str.encode('ISO-8859-1').bytes.map { |b| sprintf('%X', b) }.join
      end

    end
  end
end
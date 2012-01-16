require 'open-uri'

module Sisal
  module Providers
    class TropoProvider < Provider
      API_URL = "https://api.tropo.com/1.0/sessions"
      TOKEN   = "0c009a3f50845743b5784070823b5e7a09142571707d5e10720e2eb45bf1757dda31e6c9216c2ff7d1b2cd3e"

      def initialize(token)
        @token = token
      end

      def deliver(number, message)
        to = number.delete '+'
        url = API_URL + "?action=create&token=#{@token}&to=#{to}&msg=#{URI.escape(message)}"
        parse_response open(url).read
      end

      def parse_response(data)
        matches = data.match /\<success\>([a-z]+).*\<id\>([^<]+)/
        success = matches[1] == "true"
        Sisal::Response.new(success, matches[1], "")
      end
    end
  end
end
require 'open-uri'

module Sisal
  module Providers
    class ClickatellProvider < Provider
      API_URL = "http://api.clickatell.com/http"

      def initialize(session_id)
        @session_id = session_id
      end

      def deliver(number, message)
        to = number.delete '+'
        url = API_URL + "/sendmsg?session_id=#{@session_id}&to=#{to}&udh=#{message[:udh]}&data=#{message[:data]}"
        parse_response open(url).read
        # puts url
      end

      def parse_response(data)
        matches = data.match /(ID): ([a-z0-9]+)/
        success = matches[1] == "ID"
        Sisal::Response.new(success, matches[2], "")
      end
    end
  end
end
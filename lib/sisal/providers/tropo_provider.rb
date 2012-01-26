require 'rest_client'

module Sisal
  module Providers
    class TropoProvider < Provider
      API_URL         = "https://api.tropo.com/1.0/sessions"
      # Let's use a regex against the xml response, thus we don't need
      # to add dependencies like xml or json parser
      RESPONSE_REGEX  = /\<success\>(?<success>[^<]+)\<\/success\>.*\<id\>(?<id>[^<]+)<\/id\>/

      attr_accessor :token

      def initialize(options)
        @token = options[:token]
      end

      def deliver(to, message)
        params = { action: "create", token: @token, to: to, msg: message.text }
        response = parse_response(RestClient.get(API_URL, params: params))
        success = (response[:success] == "true")
        id = response[:id].to_s.gsub(/[^a-z0-9]/i, '')
        Sisal::Response.new(success, id)
      end

      def parse_response(data)
        data.match(RESPONSE_REGEX) || {}
      end
    end
  end
end
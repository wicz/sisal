require 'rest_client'

module Sisal
  module Providers
    class ClickatellProvider < Provider
      API_URL         = "https://api.clickatell.com/http"
      RESPONSE_REGEX  = /(?<status>OK|ERR|ID):\s*(?<code>[a-z0-9]+)?(,\s*(?<description>.*))?/

      AuthenticationFailed  = Class.new(StandardError)

      attr_accessor :session_id, :api_id, :user, :password

      def execute(command, params = {})
        url = API_URL + "/#{command}"
        RestClient.get(url, params: params)
      end

      def self.build_from_session(session_id)
        instance = new(nil, nil, nil)
        instance.session_id = session_id
        instance
      end

      def initialize(api_id, user, password)
        @api_id, @user, @password = api_id, user, password
      end

      def authenticate
        params = { api_id: @api_id, user: @user, password: @password }
        response = parse_response(execute(:auth, params))
        success = (response[:status] == "OK")
        raise AuthenticationFailed unless success
        @session_id = response[:code]
      end

      def authenticated?
        return false unless @session_id
        response = parse_response(execute(:ping, session_id: @session_id))
        response[:status] == "OK"
      end

      def deliver(to, message)
        response = execute(:sendmsg, session_id: @session_id, to: to, text: message.text)
        response = parse_response(response)
        success = (response[:status] == "ID")
        Sisal::Response.new(success, response[:code], description: response[:description])
      end

      def parse_response(data)
        data.to_s.match RESPONSE_REGEX
      end
    end
  end
end
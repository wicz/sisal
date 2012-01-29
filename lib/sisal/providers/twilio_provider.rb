require 'twilio-ruby'

module Sisal
  module Providers
    class TwilioProvider < Provider
      SID_REGEX = /\/(?<sid>[a-z0-9]+)\>/i

      attr_accessor :account_id, :token, :from

      def initialize(options = {})
        @account_id = options[:account_id]
        @token      = options[:token]
        @from       = options[:from]
        @client     = Twilio::REST::Client.new(@account_id, @token)
      end

      def deliver(to, message)
        response = parse_response(@client.account.sms.messages.create(from: @from, to: to, body: message.text))
        success = !!response[:sid]
        sid = response[:sid].to_s
        Sisal::Response.new(success, sid)
      rescue Twilio::REST::RequestError => e
        Sisal::Response.new(false, e.message)
      end

      def parse_response(data)
        data.inspect.match SID_REGEX
      end

    end
  end
end
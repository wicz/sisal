require 'spec_helper'

describe Sisal::Providers::TwilioProvider do
  let(:provider)  { Sisal::Providers::TwilioProvider.new('123abc', '123poi', '55123') }
  let(:message)   { double(:message, inspect: "<Twilio::REST::Message @uri=/2010-04-01/Accounts/123/SMS/Messages/123abc>") }

  describe "#new" do
    it "initializes with account id, auth token and sender number" do
      provider.account_id.should eq('123abc')
      provider.token.should eq('123poi')
      provider.from.should eq('55123')
    end
  end

  describe "#parse_response" do
    it "parses success" do
      response = provider.parse_response(message)
      response[:sid].should eq('123abc')
    end
  end

end
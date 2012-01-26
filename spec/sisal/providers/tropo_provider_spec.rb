require 'spec_helper'

describe Sisal::Providers::TropoProvider do
  let(:provider)  { Sisal::Providers::TropoProvider.new(token: '123') }
  let(:xml)       { "<session><success>true</success><token>123</token><id>123abc</id></session>" }

  before(:each) do
    stub_request(:get, /.*token=valid*/).to_return(body: xml)
    stub_request(:get, /.*token=invalid*/)
  end

  describe "#new" do
    it "initializes with token" do
      provider.token.should eq('123')
    end
  end

  describe "#parse_response" do
    it "parses success" do
      response = provider.parse_response(xml)
      response[:success].should eq('true')
      response[:id].should eq('123abc')
    end
  end

  describe "#deliver" do
    it "return success response when return xml" do
      provider.token = 'valid'
      response = provider.deliver('55123', double(:message, text: 'Hello MU!'))
      response.should be_a(Sisal::Response)
      response.success?.should be_true
      response.code.should eq('123abc')
    end

    it "return fail when return empty (Tropo fails silently)" do
      provider.token = 'invalid'
      response = provider.deliver('55123', double(:message, text: "FUUUU!"))
      response.should be_a(Sisal::Response)
      response.success?.should be_false
    end
  end
end
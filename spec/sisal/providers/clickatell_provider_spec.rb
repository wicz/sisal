require 'spec_helper'

describe Sisal::Providers::ClickatellProvider do

  before(:each) do
    stub_request(:get, /auth.*password=pass.*/).to_return(body: "OK: 123abc")
    stub_request(:get, /auth.*password=wrongpass.*/).to_return(body: "ERR: 001, Authentication failed.")
    stub_request(:get, /(sendmsg|ping).*session_id=expired.*/).to_return(body: "ERR: 003, Session ID expired")
    stub_request(:get, /ping.*session_id=alive.*/).to_return(body: "OK:")
    stub_request(:get, /sendmsg.*session_id=123&text=Hello%20MU!&to=55123.*/).to_return(body: "ID: 123abc")
  end

  let(:provider) { Sisal::Providers::ClickatellProvider.new('api_id', 'user', 'pass') }

  describe "::build_from_session" do
    it "initializes from session_id" do
      provider = Sisal::Providers::ClickatellProvider.build_from_session('session_id')
      provider.session_id.should eq('session_id')
    end
  end

  describe "#authenticate" do
    it "sets session_id when authenticate successfully" do
      provider.authenticate
      provider.session_id.should eq('123abc')
    end

    it "raises an error when authentication fail" do
      provider.password = 'wrongpass'
      expect { provider.authenticate }.to raise_error(Sisal::Providers::ClickatellProvider::AuthenticationFailed)
    end
  end

  describe "#authenticated?" do
    it "is false when session_id not set" do
      provider.authenticated?.should be_false
    end

    it "is false is session expired" do
      provider.session_id = 'expired'
      provider.authenticated?.should be_false
    end

    it "is true if session alive" do
      provider.session_id = 'alive'
      provider.authenticated?.should be_true
    end
  end

  describe "#execute" do
    it "delegates to RestClient" do
      RestClient.should_receive(:get).with('https://api.clickatell.com/http/command', params: {})
      provider.execute(:command)
    end
  end

  describe "#parse_response" do
    it "parses 'OK:' ping responses have no id" do
      response = provider.parse_response("OK:")
      response[:status].should eq('OK')
      response[:code].should be_nil
      response[:description].should be_nil
    end

    it "parses 'OK: session_id'" do
      response = provider.parse_response("OK: 123abc")
      response[:status].should eq('OK')
      response[:code].should eq('123abc')
      response[:description].should be_nil
    end

    it "parses 'ERR: code, description'" do
      response = provider.parse_response("ERR: 401, Authentication failed")
      response[:status].should eq('ERR')
      response[:code].should eq('401')
      response[:description].should eq('Authentication failed')
    end

    it "parses 'ID: id'" do
      response = provider.parse_response('ID: 123abc')
      response[:status].should eq('ID')
      response[:code].should eq('123abc')
      response[:description].should be_nil
    end
  end

  describe "#deliver" do
    it "response is successful when message is sent" do
      provider.session_id = '123'
      response = provider.deliver('55123', double(:message, text: "Hello MU!"))
      response.should be_a(Sisal::Response)
      response.success?.should be_true
      response.code.should eq('123abc')
    end

    it "reponse is failed when message cant be sent" do
      provider.session_id = 'expired'
      response = provider.deliver('55123', double(:message, text: "This will fail =("))
      response.should be_a(Sisal::Response)
      response.success?.should be_false
      response.code.should eq('003')
      response.params[:description].should eq('Session ID expired')
    end
  end

end
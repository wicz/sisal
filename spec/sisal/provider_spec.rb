require 'spec_helper'

describe Sisal::Provider do
  let(:provider) { Sisal::Provider.new }
  let(:message) { double(:message, to: ['55001', '55002']).as_null_object }

  describe "#deliver" do
    it "must be implemented by children classes" do
      expect { provider.deliver(nil, nil) }.to raise_error(RuntimeError)
    end
  end

  describe "#send" do
    it "deliver to all recipients" do
      provider.should_receive(:deliver).with('55001', message)
      provider.should_receive(:deliver).with('55002', message)
      provider.send message
    end

    it "returns an array of responses" do
      response = double(:response)
      provider.should_receive(:deliver).twice.and_return(response)
      provider.send(message).should eq([response, response])
    end
  end
end
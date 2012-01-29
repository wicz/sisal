require 'spec_helper'

describe Sisal::Messenger do
  let(:messenger) { Sisal::Messenger.new }
  let(:message)   { double(:message).as_null_object }

  describe "#send" do
    it "uses the default provider" do
      Sisal.configuration.default_provider.should_receive(:send).with(message)
      messenger.send(message)
    end

    it "can have provider overriden in runtime" do
      Sisal.configuration.providers['twilio'].should_receive(:send).with(message)
      messenger.send(message, provider: 'twilio')
    end
  end
end
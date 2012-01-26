require 'spec_helper'

describe Sisal::Messenger do
  let(:messenger) { Sisal::Messenger.new }
  let(:message)   { double(:message) }

  describe "#send" do
    it "uses the default provider" do
      Sisal.providers[Sisal.default_provider.to_s].should_receive(:send).with(message)
      messenger.send(message)
    end

    it "can have provider overriden in runtime" do
      Sisal.providers['twilio'].should_receive(:send).with(message)
      messenger.send(message, provider: 'twilio')
    end
  end
end
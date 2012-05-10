require "spec_helper"

describe Sisal::Messenger do
  let(:messenger) { Sisal::Messenger.new }
  let(:message)   { Sisal::Message.new("1234", "OHAI!") }
  let(:dummy)     { DummyProvider.new }
  let(:dumber)    { DummyProvider.new }

  before(:each) do
    Sisal.configuration.provider(:dummy, dummy)
    Sisal.configuration.provider(:dumber, dumber)
    Sisal.configuration.default_provider = :dummy
  end

  describe "#send" do
    it "uses the default provider" do
      dummy.should_receive(:send).with(message, {})
      messenger.send(message)
    end

    it "can have provider overriden in runtime" do
      dumber.should_receive(:send).with(message, {})
      messenger.send(message, provider: "dumber")
    end

    it "can have extra parameters" do
      dummy.should_receive(:send).with(message, msg_id: 123)
      messenger.send(message, msg_id: 123)
    end
  end
end

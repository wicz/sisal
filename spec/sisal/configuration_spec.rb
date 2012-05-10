require "spec_helper"

describe Sisal::Configuration do
  let(:dummy) { DummyProvider.new }

  before(:each) do
    Sisal.configuration.provider(:dummy, dummy)
  end

  it "has a default provider" do
    Sisal.configuration.default_provider = :dummy
    Sisal.configuration.default_provider.should be(dummy)
  end

  it "has providers" do
    Sisal.configuration.providers.should_not be_empty
  end

  describe "#provider" do
    it "configures a provider" do
      Sisal.configuration.provider(:dummy) { |p| p.token = "456"}
      Sisal.configuration.providers["dummy"].should be
      Sisal.configuration.providers["dummy"].token.should eq("456")
    end
  end
end

require 'spec_helper'

describe Sisal do

  it "has a default provider" do
    Sisal.default_provider.should eq(:tropo)
  end

  it "has providers" do
    Sisal.providers.should_not be_empty
  end

  describe "#provider" do
    it "configures a provider" do
      Sisal.provider(:tropo, token: '456')
      Sisal.providers['tropo'].should be
      Sisal.providers['tropo'].token.should eq('456')
    end
  end
end
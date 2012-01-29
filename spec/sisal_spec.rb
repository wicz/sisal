require 'spec_helper'

describe Sisal do

  it "has a default provider" do
    Sisal.configuration.default_provider.should be_a(Sisal::Providers::TropoProvider)
  end

  it "has providers" do
    Sisal.configuration.providers.should_not be_empty
  end

  describe "#provider" do
    it "configures a provider" do
      Sisal.configuration.provider(:tropo) { |p| p.token = '456'}
      Sisal.configuration.providers['tropo'].should be
      Sisal.configuration.providers['tropo'].token.should eq('456')
    end
  end
end
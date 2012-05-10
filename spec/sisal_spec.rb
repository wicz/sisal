require "spec_helper"

describe Sisal do
  it "has configuration" do
    Sisal.configuration.should be_a(Sisal::Configuration)
  end
end

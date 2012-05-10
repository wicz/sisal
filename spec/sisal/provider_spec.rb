require "spec_helper"

describe Sisal::Provider do
  let(:provider)  { Sisal::Provider.new }

  describe "#send" do
    it "must be implemented by children classes" do
      expect { provider.send(nil, nil) }.to raise_error(RuntimeError)
    end
  end
end

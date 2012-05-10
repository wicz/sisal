require "spec_helper"

describe Sisal::Message do
  let(:message) { Sisal::Message.new("5525800", "") }

  describe "#valid?" do
    context "raises an error when" do
      it "number has less than 4 digits" do
        message.to = "123"
        expect { message.valid? }.to raise_error(Sisal::Message::InvalidPhoneNumber)
      end

      it "number has more than 15 digits" do
        message.to = "1" * 20
        expect { message.valid? }.to raise_error(Sisal::Message::InvalidPhoneNumber)
      end

      it "number has chars other than digits" do
        message.to = "+5525800"
        expect { message.valid? }.to raise_error(Sisal::Message::InvalidPhoneNumber)
      end
    end

    it "accepts short codes" do
      message.valid?.should be_true
    end

    it "accepts complete E.164 number" do
      message.to = "230234321324213"
      message.valid?
    end
  end
end

require 'spec_helper'

describe Sisal::Message do
  let(:message) { Sisal::Message.new(%w(5525800 5525801), '') }

  describe "#text" do
    it "encodes text to us-ascii" do
      str = 'Hello MU!'
      str.should_receive(:encode).with('US-ASCII')
      message.text = str
      message.text
    end
  end

  describe "#to" do
    it "normalizes recipients list to array" do
      message.to = '5525800'
      message.to.should eq(['5525800'])
    end

    it "flatten the recipients list" do
      message.to.should have(2).items
    end
  end

  describe "#valid?" do
    it "validates numbers and message size" do
      message.should_receive :validate_numbers
      message.should_receive :validate_encoding
      message.should_receive :validate_message_size
      message.valid?
    end
  end

  describe "#validate_numbers" do
    it "validates each number" do
      message.should_receive(:valid_number?).twice
      message.validate_numbers
    end
  end

  describe "#valid_number?" do
    context "raises an error when" do
      it "has less than 4 digits" do
        expect { message.valid_number?('123') }.to raise_error(Sisal::Message::InvalidPhoneNumber)
      end

      it "has more than 15 digits" do
        expect { message.valid_number?('1' * 20) }.to raise_error(Sisal::Message::InvalidPhoneNumber)
      end

      it "has chars other than digits" do
        expect { message.valid_number?('+5525800') }.to raise_error(Sisal::Message::InvalidPhoneNumber)
      end
    end

    it "accepts short codes" do
      message.valid_number?('5525800').should be_true
    end

    it "accepts complete E.164 number" do
      message.valid_number?('230234321324213')
    end
  end

  describe "#validate_message_size" do
    it "raises an error when message larger than 140 chars" do
      message.text = 'KTHXBYE' * 50
      expect { message.validate_message_size }.to raise_error(Sisal::Message::MessageTooLarge)
    end
  end

  describe "#validate_encoding" do
    it "raises an error when not compatible with ASCII" do
      message.text = 'Hello MU!'.force_encoding('UTF-16BE')
      expect { message.validate_encoding }.to raise_error(Sisal::Message::InvalidEncoding)
    end
  end
end
require "spec_helper"

describe Sisal::Response do
  let(:response) { Sisal::Response.new(true, "200", "Success") }

  describe "#new" do
    it "initializes with success, code and message" do
      response.success.should be_true
      response.code.should eq("200")
      response.message.should eq("Success")
    end

    it "can initialize with extra parameters" do
      response = Sisal::Response.new(false, "401", "Error", description: "Access denied")
      response.params.has_key?(:description).should be_true
      response.params[:description].should eq("Access denied")
    end
  end

  describe "#success?" do
    it "checks if success is true" do
      response.success = true
      response.success?.should be_true
      response.success = false
      response.success?.should be_false
    end
  end
end

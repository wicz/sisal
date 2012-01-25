require 'spec_helper'

describe Sisal::Response do
  let(:response) { Sisal::Response.new(true, '200') }

  describe "#new" do
    it "initializes with success and code" do
      response.success.should be_true
      response.code.should eq('200')
    end

    it "can initialize with extra parameters" do
      response = Sisal::Response.new(false, '401', description: 'Access denied')
      response.params.has_key?(:description).should be_true
      response.params[:description].should eq('Access denied')
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
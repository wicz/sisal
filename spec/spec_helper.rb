$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require "rspec"

require_relative "../lib/sisal"

DummyProvider = Struct.new(:token)

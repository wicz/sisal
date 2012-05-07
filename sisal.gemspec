# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sisal/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Vinicius Horewicz"]
  gem.email         = ["vinicius@horewi.cz"]
  gem.description   = %q{Sisal is an abstraction layer to work with SMS. Think something like Active Merchant, but instead of payment gateways and credit cards, it deals with SMS providers and messages.}
  gem.summary       = %q{SMS abstraction layer in Ruby}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  gem.name          = "sisal"
  gem.require_paths = ["lib"]
  gem.version       = Sisal::VERSION

  gem.add_dependency "rest-client", "~> 1.6.7"
  gem.add_dependency "twilio-ruby", "~> 3.6.0"
end

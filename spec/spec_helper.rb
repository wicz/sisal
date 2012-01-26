require 'webmock/rspec'

require_relative '../lib/sisal'

Sisal.configure do |config|
  config.default_provider = :tropo
  provider :tropo,  { token: '123' }
  provider :twilio, { account_id: '123', token: '123', from: '55250'}
end
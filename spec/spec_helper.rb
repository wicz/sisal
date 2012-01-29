require 'webmock/rspec'

require_relative '../lib/sisal'

config = Sisal.configuration
config.default_provider = :tropo
config.provider(:tropo, Sisal::Providers::TropoProvider.new(token: '123'))
config.provider(:clickatell,  Sisal::Providers::ClickatellProvider.new(api_id: '123', user: 'user', password: 'pass'))
config.provider(:twilio,       Sisal::Providers::TwilioProvider.new(account_id: '123', token: '123', from: '552500'))
# Sisal - SMS Abstraction Layer

Sisal is an abstraction layer to work with SMS. Think something like
Active Merchant, but instead of payment gateways and credit cards, it
deals with SMS providers and messages.

## Architecture

At this moment Sisal's core is formed by four parts:

* Message
* Response
* Provider
* Messenger

`Message` and `Response` are the implementations for the message and you
want send and the response from the provider, respectively. `Provider` is
interface for all the providers implementations. And `Messenger` is a proxy
for all your configured providers. Check the examples below.

Sisal can send messages via the following providers:

* Tropo
* Twilio
* Clickatell

#### **Please note that Sisal ONLY supports US-ASCII (GSM 7-bit encoding) messages!**

## TODO

* Separate providers implementations, e.g. sisal-tropo, sisal-twilio
* Implement encodings LATIN1 and UCS2
* Support for binary messages: EMS, Nokia's Smart Messaging and MMS
* Evolve provider configuration to a more flexible solution like `Sisal.provider(name, &block)`
* Support for binary Concatenated SMS
* etc.

## Examples

###### Send SMS using provider

```ruby
message = Sisal::Message.new('552500', 'Hello MU!')
provider = Sisal::Providers::TropoProvider(token: '123')
provider.send(message)
```

###### Send SMS using Messenger

Assuming you have configured your providers:

```ruby
Sisal.configure do |config|
  config.default_provider = :tropo
  provider :tropo,  { token: '123' }
  provider :twilio, { account_id: '123', token: '123', from: '55600' }
end
```

You can send messages just as simple as:

```ruby
messenger = Sisal::Messenger.new
messenger.send(message)
```

You can also change your default provider on the fly:

```ruby
messenger.send(message, provider: 'twilio')
```
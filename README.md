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
* Support for binary Concatenated SMS
* etc.

## Examples

###### Send SMS using provider

```ruby
message = Sisal::Message.new('552500', 'Hello MU!')
provider = Sisal::Providers.tropo(token: '123')
provider.send(message)
```

###### Send SMS using Messenger

Assuming you have configured your providers:

```ruby
config = Sisal.configuration
config.default_provider = :tropo
config.provider(:tropo,  Sisal::Providers.tropo(token: '123'))
config.provider(:twilio, Sisal::Providers.twilio(account_id: '123', token: '123', from: '552500'))
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

If you need, you can change your providers settings:

```ruby
config.provider(:tropo) do |p|
  p.token = '312'
end
```

## License

Copyright (c) 2012 Vinicius Horewicz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished
to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

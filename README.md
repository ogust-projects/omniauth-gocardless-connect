# OmniAuth::GocardlessConnect

Gocardless Connect OAuth2 Strategy for OmniAuth 1.0.

Supports the OAuth 2.0 server-side and client-side flows.
Read the Gocardless Connect docs for more details: https://gocardless.com/connect

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-gocardless-connect'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-gocardless-connect

## Usage

OmniAuth::Strategies::GocardlessConnect is simply a Rack middleware. Read the OmniAuth
1.0 docs for detailed instructions: https://github.com/intridea/omniauth.

### Non-Devise
Here's a quick example, adding the middleware to a Rails app in
`config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :gocardless_connect, ENV['STRIPE_CONNECT_CLIENT_ID'], ENV['STRIPE_SECRET']
end
```

### Devise

You need to declare the provider in your `config/initializers/devise.rb`:

```ruby
config.omniauth :gocardless_connect, "STRIPE_CONNECT_CLIENT_ID", "STRIPE_SECRET"
```

### General Usage

Your `STRIPE_CONNECT_CLIENT_ID` is application-specific and your `STRIPE_SECRET` is account-specific and may also be known as your Gocardless API key or Gocardless Private key.

Edit your routes.rb file to have:
`devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }`

And create a file called `omniauth_callbacks_controller.rb` which should have this inside:
```ruby
class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def gocardless_connect
    # Delete the code inside of this method and write your own.
    # The code below is to show you where to access the data.
    raise request.env["omniauth.auth"].to_yaml
  end
end
```

Make sure to go to Gocardless's Account Settings > Applications and set your Redirect URL to:
`http://localhost:3003/users/auth/gocardless_connect/callback`

The Webhook URL will be something similar:
`http://www.yourdomain.com/users/auth/gocardless_connect/callback`

Then you can hit `/auth/gocardless_connect`

If you hit `/auth/gocardless_connect` with any query params, they will be passed along to Gocardless. You can access these params from `request.env['omniauth.params']`. Read [Gocardless's OAuth Reference](https://gocardless.com/docs/connect/reference) for more information.

## Auth Hash

Here is an example of the Auth Hash you get back from calling `request.env['omniauth.auth']`:

```ruby
{
  "provider"=>"gocardless_connect",
  "uid"=>"<STRIPE_USER_ID>",
  "info"=> {
    "email"=>"email@example.com",
    "name"=>"Name",
    "nickname"=>"Nickname",
    "scope"=>"read_write", # or "read_only"
    "livemode"=>false,
    "gocardless_publishable_key"=>"<STRIPE_PUBLISHABLE_KEY>",
  },
  "credentials"=> {
    "token"=>"<STRIPE_ACCESS_TOKEN>",
    "refresh_token"=>"<STRIPE_REFRESH_TOKEN>",
    "expires"=>false
  },
  "extra"=> {
    "raw_info"=> {
      "token_type"=>"bearer",
      "gocardless_user_id"=>"<STRIPE_USER_ID>",
      "scope"=>"read_only",
      "gocardless_publishable_key"=>"<STRIPE_PUBLISHABLE_KEY>",
      "livemode"=>false
    },
    "extra_info"=> {
      "business_logo"=>"https://gocardless.com/business_logo.png",
      "business_name"=>"Business Name",
      "business_url"=>"example.com",
      "charges_enabled"=>true,
      "country"=>"US",
      "default_currency"=>"eur",
      "details_submitted"=>true,
      "display_name"=>"Business Name",
      "email"=>"email@example.com",
      "id"=>"<STRIPE_USER_ID>",
      "managed"=>false,
      "object"=>"account",
      "statement_descriptor"=>"EXAMPLE.COM",
      "support_email"=>"support@example.com",
      "support_phone"=>"123456789",
      "timezone"=>"Europe/Berlin",
      "transfers_enabled"=>true
    }
  }
}
```

## Additional Tutorials
[Gocardless Connect in Rails Tutorial](http://www.munocreative.com/nerd-notes/winvoice)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

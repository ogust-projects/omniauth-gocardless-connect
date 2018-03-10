# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-gocardless-connect/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Isaac Sanders"]
  gem.email         = ["isaac@isaacbfsanders.com"]
  gem.description   = %q{Gocardless Connect OAuth2 Strategy for OmniAuth 1.0.}
  gem.summary       = %q{
Supports the OAuth 2.0 server-side and client-side flows.
Read the Gocardless Connect docs for more details: https://gocardless.com/docs/connect
}
  gem.homepage      = "https://gocardless.com/docs/connect"

  gem.files         = `git ls-files | grep -v example`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "omniauth-gocardless-connect"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::GocardlessConnect::VERSION

  gem.add_dependency 'omniauth', '~> 1.3'
  gem.add_dependency 'omniauth-oauth2', '~> 1.4'
end
